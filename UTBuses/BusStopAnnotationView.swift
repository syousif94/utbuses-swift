//
//  BusStopAnnotationView.swift
//  UTBusses
//
//  Created by Sammy Yousif on 2/25/16.
//  Copyright © 2016 Sammy Yousif. All rights reserved.
//

import UIKit
import MapKit

class BusStopAnnotationView: MKAnnotationView {

    override init(annotation:MKAnnotation?, reuseIdentifier:String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = CGRectMake(0, 0, 14, 14)
        self.centerOffset = CGPointMake(0,0)
        self.opaque = false
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override func drawRect(rect: CGRect) {
        UTBussesStyles.drawBusStop()
    }

}
