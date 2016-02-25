//
//  MapViewController.swift
//  Park@Mine
//
//  Created by Sammy Yousif on 2/10/16.
//  Copyright © 2016 Sammy Yousif. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    var timer: NSTimer?
    
    var spots = [String:SpotAnnotation]()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        
        map.showsPointsOfInterest = false
        
        let location = CLLocationCoordinate2D(
            latitude: 30.286267,
            longitude: -97.742528
        )
        
        let span = MKCoordinateSpanMake(0.02, 0.02)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
        // Query location by region
        let center = CLLocation(latitude: 30.286267, longitude: -97.742528)
        let query = geoFire.queryAtLocation(center, withRadius: 0.6)
        
        query.observeEventType(.KeyEntered, withBlock: { (key: String!, location: CLLocation!) in
            self.wcDataRef.childByAppendingPath(key).observeSingleEventOfType(.Value, withBlock: { snapshot in
                let deviceTime = snapshot.childSnapshotForPath("deviceTime").value as! Double
                let serverTime = snapshot.childSnapshotForPath("timestamp").value as! Double
                let spot = SpotDatum(location: location, deviceTime: deviceTime, serverTime: serverTime)
                let annotation = SpotAnnotation(location: spot.location, time: spot.deviceTime)
                self.spots[key] = annotation
                self.map.addAnnotation(annotation)
            })
        })
        
        query.observeEventType(.KeyExited, withBlock: { (key: String!, location: CLLocation!) in
            if let annotation = self.spots[key] {
                self.map.removeAnnotation(annotation)
                self.spots[key] = nil
            }
        })
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "refreshPinBackgrounds", userInfo: nil, repeats: true)
    }
    
    func refreshPinBackgrounds() {
        for (_, annotation) in spots {
            let annotationView = map.viewForAnnotation(annotation) as! SpotAnnotationView
            annotationView.refresh()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // need to replace mkannotation with annotation type that has type
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var v : MKAnnotationView! = nil
        //another identity of stop is required
        let ident = "spot"
        v = mapView.dequeueReusableAnnotationViewWithIdentifier(ident)
        if v == nil {
            v = SpotAnnotationView(annotation:annotation, reuseIdentifier:ident)
        }
        v.annotation = annotation
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
