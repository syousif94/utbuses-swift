//
//  SpotAnnotation.swift
//  Park@Mine
//
//  Created by Sammy Yousif on 2/12/16.
//  Copyright © 2016 Sammy Yousif. All rights reserved.
//

import UIKit
import MapKit

class SpotAnnotation : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var time: NSDate
    
    init(location coord:CLLocationCoordinate2D, time: NSDate) {
        self.coordinate = coord
        self.time = time
        super.init()
    }
    
}
