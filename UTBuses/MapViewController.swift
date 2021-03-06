//
//  MapViewController.swift
//  Park@Mine
//
//  Created by Sammy Yousif on 2/10/16.
//  Copyright © 2016 Sammy Yousif. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Firebase

let kPostButton = "The bus is here!"
let kUndoButton = "Just kidding!"
let kFirebaseServerValueTimestamp = [".sv":"timestamp"]

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIApplicationDelegate {
    
    @IBOutlet weak var stopList: UIView!
 
    @IBAction func didTapStopsNotificationsBtn(sender: AnyObject) {
        stopsNotificationsBtn.open = !stopsNotificationsBtn.open
        stopsNotificationsBtn.pressed = false
        stopsNotificationsBtn.setNeedsDisplay()
        
        if stopsNotificationsBtn.open {
            stopList.layer.hidden = false
        } else {
            stopList.layer.hidden = true
        }
    }
    @IBOutlet weak var stopsNotificationsBtn: NotificationButtonView!
    @IBOutlet weak var undoTimeLeft: CircleProgressView!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var btnBg: UIView!
    @IBOutlet weak var gotOnBtn: UIButton!
    @IBAction func gotOnBtn(sender: AnyObject) {
        switch CLLocationManager.authorizationStatus() {
        case .AuthorizedWhenInUse:
            checkInOnBus()
        case .NotDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .Denied, .Restricted:
            if let appSettings = NSURL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.sharedApplication().openURL(appSettings)
            }
        default:
            break
        }
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    let notificationCenter = NSNotificationCenter.defaultCenter()
    
    let notification = CWStatusBarNotification()
    
    let minDistanceFromStop: Double = 60.69 // 200 feet
    
    var checkInRef: Firebase?
    
    var undoPercetage: Double = 0
    
    func stopUndoCountdown() {
        checkInRef = nil
        undoTimer?.invalidate()
        undoTimer = nil
        dispatch_async(dispatch_get_main_queue()) {
            self.undoTimeLeft.hidden = true
        }
        undoPercetage = 0
        undoTimeLeft.progress = undoPercetage
        dispatch_async(dispatch_get_main_queue()) {
            self.gotOnBtn.setTitle(kPostButton, forState: .Normal)
            self.gotOnBtn.setTitleColor(UTBussesStyles.buttonBlue, forState: .Normal)
        }
    }
    
    func updateUndoCircle() {
        undoPercetage = undoPercetage + 0.01
        undoTimeLeft.progress = undoPercetage
        if undoPercetage >= 1 {
            stopUndoCountdown()
        }
    }
    
    func checkInOnBus() {
        if let key = checkInRef?.key {
            self.removePin(key)
            geoFire.removeKey(key)
            checkInRef?.removeValue()
            stopUndoCountdown()
            return
        }
        let deviceTime = NSDate().timeIntervalSince1970 * 1000
        let location = map.userLocation.location
        if let l = location {
            /*
            if l.horizontalAccuracy > minDistanceFromStop {
                return
            }*/
            let distances = wcStops.filter() { (stop: busStop) in
                let stop = CLLocation(latitude: stop.location.latitude, longitude: stop.location.longitude)
                let distance = l.distanceFromLocation(stop)
                if distance <= minDistanceFromStop {
                    return true
                }
                return false
            }
            if distances.count < 1 {
                self.notification.displayNotificationWithMessage("If you're within 200 feet of a stop, please try again.", forDuration: 1.7)
                return
            }
            let stop = distances[0]
            checkInRef = wcDataRef.childByAutoId()
            createPin(checkInRef!.key, location: l, deviceTime: deviceTime, serverTime: deviceTime)
            dispatch_async(dispatch_get_main_queue()) {
                self.gotOnBtn.setTitle(kUndoButton, forState: .Normal)
                self.gotOnBtn.setTitleColor(UIColor.redColor(), forState: .Normal)
                self.undoTimeLeft.hidden = false
            }
            undoTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(MapViewController.updateUndoCircle), userInfo: nil, repeats: true)
            let checkIn = ["deviceTime": deviceTime, "timestamp": kFirebaseServerValueTimestamp, "stopName": stop.name, "stopId": stop.id]
            checkInRef!.setValue(checkIn, withCompletionBlock: {
                (error:NSError?, ref:Firebase!) in
                if (error != nil) {
                    self.removePin(self.checkInRef!.key)
                } else {
                    self.geoFire.setLocation(l, forKey: self.checkInRef!.key) { error in
                        if (error != nil) {
                            self.removePin(self.checkInRef!.key)
                        }
                    }
                }
            })
        } else {
            self.notification.displayNotificationWithMessage("Wait until your location appears on the map.", forDuration: 1.7)
        }
    }
    
    var locationManager: CLLocationManager!
    
    var timer: NSTimer?
    
    var undoTimer: NSTimer?
    
    var fetchBusesTimer: NSTimer?
    
    var spots = [String:SpotAnnotation]()
    
    var buses = [String:SpotAnnotation]()
    
    var firebaseRef = Firebase(url:"https://utbusses.firebaseio.com")
    
    var wcDataRef : Firebase {
        return firebaseRef.childByAppendingPath("wcdata")
    }
    
    var geoFireRef : Firebase {
        return firebaseRef.childByAppendingPath("wc")
    }
    
    var geoFire : GeoFire {
        return GeoFire(firebaseRef: geoFireRef)
    }
    
    func createPin(key: String, location: CLLocation, deviceTime: Double, serverTime: Double) {
        let spot = SpotDatum(location: location, deviceTime: deviceTime, serverTime: serverTime)
        let annotation = SpotAnnotation(type: "user", location: spot.location, time: spot.deviceTime)
        if spots[key] == nil {
            dispatch_async(dispatch_get_main_queue()) {
                self.spots[key] = annotation
                self.map.addAnnotation(annotation)
            }
        }
    }
    
    func removePin(key: String) {
        if let annotation = self.spots[key] {
            dispatch_async(dispatch_get_main_queue()) {
                self.map.removeAnnotation(annotation)
                self.spots[key] = nil
            }
        }
    }
    
    func getBuses() {
        guard let URL = NSURL(string: "https://lnykjry6ze.execute-api.us-west-2.amazonaws.com/prod/gtfsrt-debug?url=https://data.texas.gov/download/eiei-9rpf/application/octet-stream") else { return }
        let request = NSURLRequest(URL: URL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            guard let d = data else {
                return
            }
            do {
                let JSON = try NSJSONSerialization.JSONObjectWithData(d, options: []) as! [String: AnyObject]
                guard let vehicles = JSON["entity"]! as? [AnyObject] else {
                    return
                }
                let vehicleList = vehicles.filter() { (vehicle) in
                    guard let routeId = vehicle["vehicle"]!!["trip"]!!["route_id"] as? String else {
                        return false
                    }
                    return routeId == "642"
                }
                for (_, bus) in self.buses {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.map.removeAnnotation(bus)
                    }
                }
                self.buses.removeAll()
                for vehicle in vehicleList {
                    let vId = vehicle["vehicle"]!!["trip"]!!["trip_id"] as! String
                    let latitude = vehicle["vehicle"]!!["position"]!!["latitude"] as! Double
                    let longitude = vehicle["vehicle"]!!["position"]!!["longitude"] as! Double
                    let time = vehicle["vehicle"]!!["timestamp"] as! Double * 1000
                    let location = CLLocation(latitude: latitude, longitude: longitude)
                    let spot = SpotDatum(location: location, deviceTime: time, serverTime: time)
                    self.buses[vId] = SpotAnnotation(type: "bus", location: spot.location, time: spot.deviceTime)
                }
                for (_, bus) in self.buses {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.map.addAnnotation(bus)
                    }
                }
            } catch {
                return
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        map.delegate = self
        map.showsPointsOfInterest = false
        map.showsCompass = false
        map.pitchEnabled = false
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            map.showsUserLocation = true
        }
        
        let location = CLLocationCoordinate2D(
            latitude: 30.286390,
            longitude: -97.740726
        )
        
        let span = MKCoordinateSpanMake(0.022, 0.022)
        let region = MKCoordinateRegion(center: location, span: span)
        dispatch_async(dispatch_get_main_queue()) {
            self.map.setRegion(region, animated: false)
        }
        
        let coordinates: [CLLocationCoordinate2D]? = decodePolyline("mgzwDrqosQuD@gBL{CfCSNe@T}@VYBm@A[vLSjFMxEwL]Q`FIv@CbDI|HhHZ?@MpC?AI`DKzD?@GbCA~A??QjEvDTdBD~F\\lCJp@FdDLpDTT_ITwHNgERqENyEnFRJaFPeFF_CZuHf@oRJu@uCGoG}@eDa@")
        let pointer: UnsafeMutablePointer<CLLocationCoordinate2D> = UnsafeMutablePointer(coordinates!)
        let polyline = MKPolyline(coordinates: pointer, count: coordinates!.count)
        dispatch_async(dispatch_get_main_queue()) {
            self.map.addOverlay(polyline)
        }
        
        for annotation in stopAnnotations {
            dispatch_async(dispatch_get_main_queue()) {
                self.map.addAnnotation(annotation)
            }
        }
        
        notification.notificationLabelBackgroundColor = UTBussesStyles.purple
        notification.notificationLabelFont = UIFont.boldSystemFontOfSize(12)
        notification.notificationAnimationInStyle = CWNotificationAnimationStyle.Top
        notification.notificationAnimationOutStyle = CWNotificationAnimationStyle.Top
        
        // Query location by region
        let center = CLLocation(latitude: 30.286267, longitude: -97.742528)
        let query = geoFire.queryAtLocation(center, withRadius: 3500)
        
        query.observeEventType(.KeyEntered, withBlock: { (key: String!, location: CLLocation!) in
            self.wcDataRef.childByAppendingPath(key).observeSingleEventOfType(.Value, withBlock: { snapshot in
                guard let deviceTime = snapshot.childSnapshotForPath("deviceTime").value as? Double else {
                    return
                }
                guard let serverTime = snapshot.childSnapshotForPath("timestamp").value as? Double else {
                    return
                }
                self.createPin(key, location: location, deviceTime: deviceTime, serverTime: serverTime)
            })
        })
        
        query.observeEventType(.KeyExited, withBlock: { (key: String!, location: CLLocation!) in
            self.removePin(key)
        })
        
        notificationCenter.addObserver(self,
            selector:#selector(MapViewController.applicationWillResignActiveNotification),
            name:UIApplicationWillResignActiveNotification,
            object:nil)
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(MapViewController.refreshPinBackgrounds), userInfo: nil, repeats: true)
        
        getBuses()
        fetchBusesTimer = NSTimer.scheduledTimerWithTimeInterval(15, target: self, selector: #selector(getBuses), userInfo: nil, repeats: true)
    }
    
    func applicationWillResignActiveNotification() {
        stopUndoCountdown()
    }
    
    func refreshPinBackgrounds() {
        for (_, annotation) in spots {
            let a: SpotAnnotation = annotation
            if a.type == "user" {
                let annotationView = map.viewForAnnotation(annotation) as? SpotAnnotationView
                if let av = annotationView {
                    dispatch_async(dispatch_get_main_queue()) {
                        av.refresh()
                    }
                }
            }
        }
        for (_, annotation) in buses {
            let a: SpotAnnotation = annotation
            if a.type == "bus" {
                let annotationView = map.viewForAnnotation(annotation) as? BusAnnotationView
                if let av = annotationView {
                    dispatch_async(dispatch_get_main_queue()) {
                        av.refresh()
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Location Manager Delegate Methods
    
    func locationManager(manager: CLLocationManager,
        didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        switch status {
        case .AuthorizedWhenInUse:
            map.showsUserLocation = true
        case .Denied:
            map.showsUserLocation = false
        default:
            break
        }
    }
    
    // MARK: - Map Delegate Methods
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        var v : MKAnnotationView! = nil
        if annotation is SpotAnnotation {
            let a = annotation as! SpotAnnotation
            let ident:String = a.type
            //v = mapView.dequeueReusableAnnotationViewWithIdentifier(a.type)
            if v == nil {
                if ident == "user" {
                    v = SpotAnnotationView(annotation:annotation, reuseIdentifier:ident)
                }
                else if ident == "stop" {
                    v = BusStopAnnotationView(annotation:annotation, reuseIdentifier:ident)
                }
                else if ident == "bus" {
                    v = BusAnnotationView(annotation:annotation, reuseIdentifier:ident)
                }
            }
        }
        v.annotation = annotation
        return v
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UTBussesStyles.routeBlue
            polylineRenderer.lineWidth = 5
            return polylineRenderer
        }
        
        let v : MKOverlayRenderer! = nil
        return v
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
