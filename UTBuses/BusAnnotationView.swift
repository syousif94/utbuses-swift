//
//  BusAnnotationView.swift
//  UT Buses
//
//  Created by Sammy Yousif on 3/29/16.
//  Copyright © 2016 Sammy Yousif. All rights reserved.
//

import Foundation

class BusAnnotationView: MKAnnotationView {

    override init(annotation:MKAnnotation?, reuseIdentifier:String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = CGRectMake(0, 0, 41, 24)
        self.centerOffset = CGPointMake(0,-12)
        self.opaque = false
        guard let annotation = annotation as? SpotAnnotation else {
            return
        }
        if let time = annotation.time {
            let milliseconds = CGFloat(time.timeIntervalSince1970 * 100)
            self.layer.zPosition = milliseconds
        }
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
        if let time = annotation.time {
            UTBussesStyles.drawBus(time)
        }
    }
    
    func refresh() {
        self.setNeedsDisplay()
    }
    
}
