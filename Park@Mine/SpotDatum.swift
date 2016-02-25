//
//  spotDatum.swift
//  UTBusses
//
//  Created by Sammy Yousif on 2/24/16.
//  Copyright © 2016 Sammy Yousif. All rights reserved.
//

struct SpotDatum {
    let location: CLLocationCoordinate2D
    let deviceTime, serverTime: NSDate
    
    init(location: CLLocation, deviceTime: Double, serverTime: Double) {
        self.location = location.coordinate
        self.deviceTime = NSDate(timeIntervalSince1970: deviceTime / 1000)
        self.serverTime = NSDate(timeIntervalSince1970: serverTime / 1000)
    }
}
