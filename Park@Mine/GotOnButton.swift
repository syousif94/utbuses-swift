//
//  GotOnButton.swift
//  UTBusses
//
//  Created by Sammy Yousif on 2/25/16.
//  Copyright © 2016 Sammy Yousif. All rights reserved.
//

import UIKit

class GotOnButton: UIButton {

    override func drawRect(rect: CGRect) {
        UTBussesStyles.drawButton(getOnButton: rect, gotOnLabel: "I just got on the bus!")
    }

}
