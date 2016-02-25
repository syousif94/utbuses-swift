//
//  SpotAnnotationView.swift
//  Park@Mine
//
//  Created by Sammy Yousif on 2/12/16.
//  Copyright © 2016 Sammy Yousif. All rights reserved.
//

import UIKit
import MapKit

class SpotAnnotationView : MKAnnotationView {
    override init(annotation:MKAnnotation?, reuseIdentifier:String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = CGRectMake(0, 0, 41, 24)
        self.centerOffset = CGPointMake(0,-12)
        self.opaque = false
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override func drawRect(rect: CGRect) {
        guard let annotation = annotation as? SpotAnnotation else {
         return
        }
        UTBussesStyles.drawPin(annotation.time)
    }
    
    func refresh() {
        self.setNeedsDisplay()
    }
}
