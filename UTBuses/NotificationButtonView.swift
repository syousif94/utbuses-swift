//
//  NotificationButtonView.swift
//  UT Buses
//
//  Created by Sammy Yousif on 3/24/16.
//  Copyright © 2016 Sammy Yousif. All rights reserved.
//

import UIKit

class NotificationButtonView: UIView {
    
    var open = false
    var pressed = false
    
    override func drawRect(rect: CGRect) {
        UTBussesStyles.drawNotificationButton(notificationButtonPressed: pressed, notificationMenuOpen: open)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        pressed = true
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        pressed = false
        self.setNeedsDisplay()
    }

}
