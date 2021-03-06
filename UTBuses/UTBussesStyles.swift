//
//  UTBussesStyles.swift
//  UTBusses
//
//  Created by Sammy Yousif on 2/23/16.
//  Copyright (c) 2016 . All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//



import UIKit

public class UTBussesStyles : NSObject {

    //// Cache

    private struct Cache {
        static let green: UIColor = UIColor(red: 0.314, green: 0.675, blue: 0.071, alpha: 1.000)
        static let red: UIColor = UIColor(red: 0.816, green: 0.008, blue: 0.106, alpha: 1.000)
        static let yellow: UIColor = UIColor(red: 0.961, green: 0.651, blue: 0.137, alpha: 1.000)
        static let buttonBlue: UIColor = UIColor(red: 0.082, green: 0.478, blue: 0.988, alpha: 1.000)
        static let routeBlue: UIColor = UIColor(red: 0.290, green: 0.565, blue: 0.886, alpha: 0.510)
        static let purple: UIColor = UIColor(red: 0.565, green: 0.075, blue: 0.996, alpha: 1.000)
        static let gray: UIColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1.000)
        static let orange: UIColor = UIColor(red: 0.800, green: 0.345, blue: 0.039, alpha: 1.000)
    }

    //// Colors

    public class var green: UIColor { return Cache.green }
    public class var red: UIColor { return Cache.red }
    public class var yellow: UIColor { return Cache.yellow }
    public class var buttonBlue: UIColor { return Cache.buttonBlue }
    public class var routeBlue: UIColor { return Cache.routeBlue }
    public class var purple: UIColor { return Cache.purple }
    public class var gray: UIColor { return Cache.gray }
    public class var orange: UIColor { return Cache.orange }

    //// Drawing Methods
    public class func drawPin(time: NSDate) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        shadow.shadowOffset = CGSizeMake(0.1, 1.1)
        shadow.shadowBlurRadius = 4
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(21.5, 22.5))
        bezierPath.addLineToPoint(CGPointMake(26.26, 18))
        bezierPath.addLineToPoint(CGPointMake(16.74, 18))
        bezierPath.addLineToPoint(CGPointMake(21.5, 22.5))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(6.11, 0))
        bezierPath.addLineToPoint(CGPointMake(34.89, 0))
        bezierPath.addCurveToPoint(CGPointMake(38.32, 0.26), controlPoint1: CGPointMake(36.65, 0), controlPoint2: CGPointMake(37.53, -0))
        bezierPath.addLineToPoint(CGPointMake(38.47, 0.3))
        bezierPath.addCurveToPoint(CGPointMake(40.7, 2.53), controlPoint1: CGPointMake(39.51, 0.68), controlPoint2: CGPointMake(40.32, 1.49))
        bezierPath.addCurveToPoint(CGPointMake(41, 6.11), controlPoint1: CGPointMake(41, 3.47), controlPoint2: CGPointMake(41, 4.35))
        bezierPath.addLineToPoint(CGPointMake(41, 11.89))
        bezierPath.addCurveToPoint(CGPointMake(40.74, 15.32), controlPoint1: CGPointMake(41, 13.65), controlPoint2: CGPointMake(41, 14.53))
        bezierPath.addLineToPoint(CGPointMake(40.7, 15.47))
        bezierPath.addCurveToPoint(CGPointMake(38.47, 17.7), controlPoint1: CGPointMake(40.32, 16.51), controlPoint2: CGPointMake(39.51, 17.32))
        bezierPath.addCurveToPoint(CGPointMake(34.89, 18), controlPoint1: CGPointMake(37.53, 18), controlPoint2: CGPointMake(36.65, 18))
        bezierPath.addLineToPoint(CGPointMake(6.11, 18))
        bezierPath.addCurveToPoint(CGPointMake(2.68, 17.74), controlPoint1: CGPointMake(4.35, 18), controlPoint2: CGPointMake(3.47, 18))
        bezierPath.addLineToPoint(CGPointMake(2.53, 17.7))
        bezierPath.addCurveToPoint(CGPointMake(0.3, 15.47), controlPoint1: CGPointMake(1.49, 17.32), controlPoint2: CGPointMake(0.68, 16.51))
        bezierPath.addCurveToPoint(CGPointMake(0, 11.89), controlPoint1: CGPointMake(0, 14.53), controlPoint2: CGPointMake(0, 13.65))
        bezierPath.addLineToPoint(CGPointMake(0, 6.11))
        bezierPath.addCurveToPoint(CGPointMake(0.26, 2.68), controlPoint1: CGPointMake(0, 4.35), controlPoint2: CGPointMake(-0, 3.47))
        bezierPath.addLineToPoint(CGPointMake(0.3, 2.53))
        bezierPath.addCurveToPoint(CGPointMake(2.53, 0.3), controlPoint1: CGPointMake(0.68, 1.49), controlPoint2: CGPointMake(1.49, 0.68))
        bezierPath.addCurveToPoint(CGPointMake(6.11, 0), controlPoint1: CGPointMake(3.47, 0), controlPoint2: CGPointMake(4.35, 0))
        bezierPath.closePath()
        CGContextSaveGState(context!)
        CGContextSetShadowWithColor(context!, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
        
        let greenTime: Double = 5 * 60
        let yellowTime: Double = 10 * 60
        
        let unixTime = time.timeIntervalSince1970
        let currentTime = NSDate().timeIntervalSince1970
        let timePast = currentTime - unixTime
        
        if timePast < greenTime {
            UTBussesStyles.green.setFill()
        } else if greenTime < timePast && timePast < yellowTime {
            UTBussesStyles.yellow.setFill()
        } else {
            UTBussesStyles.red.setFill()
        }
        bezierPath.fill()
        CGContextRestoreGState(context!)
        
        var timeStr = NSDateFormatter.localizedStringFromDate(time, dateStyle: .NoStyle, timeStyle: .ShortStyle)
        timeStr = timeStr.substringToIndex(timeStr.endIndex.predecessor().predecessor().predecessor())
        
        
        //// Text Drawing
        let textRect = CGRectMake(0, 1, 41, 14)
        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = .Center
        
        let textFontAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: UIFont.systemFontSize())!, NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: textStyle]
        
        let textTextHeight: CGFloat = NSString(string: timeStr).boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        CGContextSaveGState(context!)
        CGContextClipToRect(context!, textRect);
        NSString(string: timeStr).drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context!)
    }
    
    public class func drawButton(getOnButton getOnButton: CGRect = CGRectMake(0, 0, 320, 50), gotOnLabel: String = "I just got on the bus!") {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let buttonBlue = UIColor(red: 0.082, green: 0.478, blue: 0.988, alpha: 1.000)
        
        //// Frames
        let frame = CGRectMake(getOnButton.origin.x, getOnButton.origin.y, getOnButton.size.width, getOnButton.size.height)
        
        
        //// Rectangle Drawing
        let rectangleRect = CGRectMake(frame.minX + floor(frame.width * 0.10833 + 0.5), frame.minY + floor(frame.height * 0.00000 + 0.5), floor(frame.width * 0.87917 + 0.5) - floor(frame.width * 0.10833 + 0.5), floor(frame.height * 0.69474 + 0.5) - floor(frame.height * 0.00000 + 0.5))
        let rectanglePath = UIBezierPath(roundedRect: rectangleRect, cornerRadius: 4)
        UIColor.whiteColor().setFill()
        rectanglePath.fill()
        let rectangleStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        rectangleStyle.alignment = .Center
        
        let rectangleFontAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 18)!, NSForegroundColorAttributeName: buttonBlue, NSParagraphStyleAttributeName: rectangleStyle]
        
        let rectangleTextHeight: CGFloat = NSString(string: gotOnLabel).boundingRectWithSize(CGSizeMake(rectangleRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: rectangleFontAttributes, context: nil).size.height
        CGContextSaveGState(context!)
        CGContextClipToRect(context!, rectangleRect);
        NSString(string: gotOnLabel).drawInRect(CGRectMake(rectangleRect.minX, rectangleRect.minY + (rectangleRect.height - rectangleTextHeight) / 2, rectangleRect.width, rectangleTextHeight), withAttributes: rectangleFontAttributes)
        CGContextRestoreGState(context!)
    }
    
    public class func drawBusStop() {
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(0, 0, 14, 14))
        UTBussesStyles.buttonBlue.setFill()
        ovalPath.fill()
    }
    
    public class func drawNotificationButton(notificationButtonPressed notificationButtonPressed: Bool = false, notificationMenuOpen: Bool = true) {
        //// Color Declarations
        let color = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.757)
        
        //// Variable Declarations
        let notificationMenuClosed = notificationMenuOpen == false
        
        //// bg Drawing
        let bgPath = UIBezierPath(roundedRect: CGRectMake(0, 0, 50, 50), cornerRadius: 4)
        UIColor.whiteColor().setFill()
        bgPath.fill()
        
        
        if (notificationMenuClosed) {
            //// Bell Drawing
            let bellPath = UIBezierPath()
            bellPath.moveToPoint(CGPointMake(32.74, 30.89))
            bellPath.addCurveToPoint(CGPointMake(16.34, 30.77), controlPoint1: CGPointMake(27.3, 32.75), controlPoint2: CGPointMake(21.79, 32.71))
            bellPath.addLineToPoint(CGPointMake(16.34, 29.48))
            bellPath.addCurveToPoint(CGPointMake(17.85, 25.95), controlPoint1: CGPointMake(17.31, 28.56), controlPoint2: CGPointMake(17.85, 27.29))
            bellPath.addLineToPoint(CGPointMake(17.85, 22.13))
            bellPath.addCurveToPoint(CGPointMake(20.03, 17.1), controlPoint1: CGPointMake(17.85, 20.22), controlPoint2: CGPointMake(18.65, 18.39))
            bellPath.addCurveToPoint(CGPointMake(25.16, 15.37), controlPoint1: CGPointMake(21.43, 15.8), controlPoint2: CGPointMake(23.25, 15.19))
            bellPath.addCurveToPoint(CGPointMake(31.16, 22.45), controlPoint1: CGPointMake(28.52, 15.7), controlPoint2: CGPointMake(31.16, 18.81))
            bellPath.addLineToPoint(CGPointMake(31.16, 25.95))
            bellPath.addCurveToPoint(CGPointMake(32.74, 29.55), controlPoint1: CGPointMake(31.16, 27.33), controlPoint2: CGPointMake(31.73, 28.62))
            bellPath.addLineToPoint(CGPointMake(32.74, 30.89))
            bellPath.closePath()
            bellPath.moveToPoint(CGPointMake(24.71, 35.63))
            bellPath.addCurveToPoint(CGPointMake(21.71, 33.42), controlPoint1: CGPointMake(23.31, 35.63), controlPoint2: CGPointMake(22.14, 34.7))
            bellPath.addCurveToPoint(CGPointMake(24.72, 33.63), controlPoint1: CGPointMake(22.71, 33.54), controlPoint2: CGPointMake(23.72, 33.63))
            bellPath.addCurveToPoint(CGPointMake(27.71, 33.43), controlPoint1: CGPointMake(25.72, 33.63), controlPoint2: CGPointMake(26.71, 33.54))
            bellPath.addCurveToPoint(CGPointMake(24.71, 35.63), controlPoint1: CGPointMake(27.28, 34.7), controlPoint2: CGPointMake(26.11, 35.63))
            bellPath.addLineToPoint(CGPointMake(24.71, 35.63))
            bellPath.closePath()
            bellPath.moveToPoint(CGPointMake(24.71, 13.37))
            bellPath.addCurveToPoint(CGPointMake(25.84, 14.12), controlPoint1: CGPointMake(25.21, 13.37), controlPoint2: CGPointMake(25.64, 13.68))
            bellPath.addCurveToPoint(CGPointMake(25.29, 14.01), controlPoint1: CGPointMake(25.66, 14.08), controlPoint2: CGPointMake(25.48, 14.02))
            bellPath.addCurveToPoint(CGPointMake(23.64, 14.02), controlPoint1: CGPointMake(24.73, 13.95), controlPoint2: CGPointMake(24.18, 13.96))
            bellPath.addCurveToPoint(CGPointMake(24.71, 13.37), controlPoint1: CGPointMake(23.86, 13.64), controlPoint2: CGPointMake(24.25, 13.37))
            bellPath.addLineToPoint(CGPointMake(24.71, 13.37))
            bellPath.closePath()
            bellPath.moveToPoint(CGPointMake(33.83, 28.69))
            bellPath.addCurveToPoint(CGPointMake(32.5, 25.95), controlPoint1: CGPointMake(32.99, 28.02), controlPoint2: CGPointMake(32.5, 27.02))
            bellPath.addLineToPoint(CGPointMake(32.5, 22.45))
            bellPath.addCurveToPoint(CGPointMake(27.3, 14.53), controlPoint1: CGPointMake(32.5, 18.86), controlPoint2: CGPointMake(30.33, 15.74))
            bellPath.addCurveToPoint(CGPointMake(24.71, 12), controlPoint1: CGPointMake(27.24, 13.13), controlPoint2: CGPointMake(26.1, 12))
            bellPath.addCurveToPoint(CGPointMake(22.14, 14.33), controlPoint1: CGPointMake(23.38, 12), controlPoint2: CGPointMake(22.3, 13.02))
            bellPath.addCurveToPoint(CGPointMake(19.13, 16.09), controlPoint1: CGPointMake(21.04, 14.68), controlPoint2: CGPointMake(20.01, 15.27))
            bellPath.addCurveToPoint(CGPointMake(16.51, 22.13), controlPoint1: CGPointMake(17.46, 17.63), controlPoint2: CGPointMake(16.51, 19.83))
            bellPath.addLineToPoint(CGPointMake(16.51, 25.95))
            bellPath.addCurveToPoint(CGPointMake(15.24, 28.64), controlPoint1: CGPointMake(16.51, 26.99), controlPoint2: CGPointMake(16.05, 27.97))
            bellPath.addCurveToPoint(CGPointMake(15, 29.17), controlPoint1: CGPointMake(15.09, 28.77), controlPoint2: CGPointMake(15, 28.97))
            bellPath.addLineToPoint(CGPointMake(15, 31.25))
            bellPath.addCurveToPoint(CGPointMake(15.44, 31.89), controlPoint1: CGPointMake(15, 31.54), controlPoint2: CGPointMake(15.18, 31.8))
            bellPath.addCurveToPoint(CGPointMake(20.27, 33.22), controlPoint1: CGPointMake(17.04, 32.5), controlPoint2: CGPointMake(18.65, 32.93))
            bellPath.addCurveToPoint(CGPointMake(24.71, 37), controlPoint1: CGPointMake(20.66, 35.37), controlPoint2: CGPointMake(22.5, 37))
            bellPath.addCurveToPoint(CGPointMake(29.15, 33.23), controlPoint1: CGPointMake(26.92, 37), controlPoint2: CGPointMake(28.76, 35.37))
            bellPath.addCurveToPoint(CGPointMake(33.64, 32.03), controlPoint1: CGPointMake(30.65, 32.96), controlPoint2: CGPointMake(32.15, 32.56))
            bellPath.addCurveToPoint(CGPointMake(34.08, 31.38), controlPoint1: CGPointMake(33.9, 31.93), controlPoint2: CGPointMake(34.08, 31.67))
            bellPath.addLineToPoint(CGPointMake(34.08, 29.23))
            bellPath.addCurveToPoint(CGPointMake(33.83, 28.69), controlPoint1: CGPointMake(34.08, 29.02), controlPoint2: CGPointMake(33.99, 28.82))
            bellPath.addLineToPoint(CGPointMake(33.83, 28.69))
            bellPath.closePath()
            bellPath.miterLimit = 4;
            
            bellPath.usesEvenOddFillRule = true;
            
            UTBussesStyles.buttonBlue.setFill()
            bellPath.fill()
        }
        
        
        if (notificationButtonPressed) {
            //// highlight Drawing
            let highlightPath = UIBezierPath(roundedRect: CGRectMake(0, 0, 50, 50), cornerRadius: 4)
            color.setFill()
            highlightPath.fill()
        }
        
        
        if (notificationMenuOpen) {
            //// Close Drawing
            let closePath = UIBezierPath()
            closePath.moveToPoint(CGPointMake(31.61, 18.41))
            closePath.addCurveToPoint(CGPointMake(29.71, 18.41), controlPoint1: CGPointMake(31.09, 17.9), controlPoint2: CGPointMake(30.23, 17.9))
            closePath.addLineToPoint(CGPointMake(25.01, 23.11))
            closePath.addLineToPoint(CGPointMake(20.32, 18.41))
            closePath.addCurveToPoint(CGPointMake(18.41, 18.41), controlPoint1: CGPointMake(19.8, 17.9), controlPoint2: CGPointMake(18.93, 17.9))
            closePath.addCurveToPoint(CGPointMake(18.41, 20.31), controlPoint1: CGPointMake(17.9, 18.93), controlPoint2: CGPointMake(17.9, 19.79))
            closePath.addLineToPoint(CGPointMake(23.11, 25.01))
            closePath.addLineToPoint(CGPointMake(18.41, 29.71))
            closePath.addCurveToPoint(CGPointMake(18.41, 31.61), controlPoint1: CGPointMake(17.9, 30.23), controlPoint2: CGPointMake(17.9, 31.09))
            closePath.addCurveToPoint(CGPointMake(19.37, 32), controlPoint1: CGPointMake(18.68, 31.87), controlPoint2: CGPointMake(19.02, 32))
            closePath.addCurveToPoint(CGPointMake(20.32, 31.61), controlPoint1: CGPointMake(19.71, 32), controlPoint2: CGPointMake(20.05, 31.87))
            closePath.addLineToPoint(CGPointMake(25.01, 26.91))
            closePath.addLineToPoint(CGPointMake(29.71, 31.61))
            closePath.addCurveToPoint(CGPointMake(30.66, 32), controlPoint1: CGPointMake(29.98, 31.87), controlPoint2: CGPointMake(30.32, 32))
            closePath.addCurveToPoint(CGPointMake(31.61, 31.61), controlPoint1: CGPointMake(31, 32), controlPoint2: CGPointMake(31.34, 31.87))
            closePath.addCurveToPoint(CGPointMake(31.61, 29.71), controlPoint1: CGPointMake(32.13, 31.09), controlPoint2: CGPointMake(32.13, 30.23))
            closePath.addLineToPoint(CGPointMake(26.91, 25.01))
            closePath.addLineToPoint(CGPointMake(31.61, 20.31))
            closePath.addCurveToPoint(CGPointMake(31.61, 18.41), controlPoint1: CGPointMake(32.13, 19.79), controlPoint2: CGPointMake(32.13, 18.93))
            closePath.closePath()
            closePath.miterLimit = 4;
            
            UIColor.blackColor().setFill()
            closePath.fill()
        }
    }
    
    public class func drawBus(time: NSDate) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        shadow.shadowOffset = CGSizeMake(0.1, 1.1)
        shadow.shadowBlurRadius = 4
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(21.5, 22.5))
        bezierPath.addLineToPoint(CGPointMake(26.26, 18))
        bezierPath.addLineToPoint(CGPointMake(16.74, 18))
        bezierPath.addLineToPoint(CGPointMake(21.5, 22.5))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(6.11, 0))
        bezierPath.addLineToPoint(CGPointMake(34.89, 0))
        bezierPath.addCurveToPoint(CGPointMake(38.32, 0.26), controlPoint1: CGPointMake(36.65, 0), controlPoint2: CGPointMake(37.53, -0))
        bezierPath.addLineToPoint(CGPointMake(38.47, 0.3))
        bezierPath.addCurveToPoint(CGPointMake(40.7, 2.53), controlPoint1: CGPointMake(39.51, 0.68), controlPoint2: CGPointMake(40.32, 1.49))
        bezierPath.addCurveToPoint(CGPointMake(41, 6.11), controlPoint1: CGPointMake(41, 3.47), controlPoint2: CGPointMake(41, 4.35))
        bezierPath.addLineToPoint(CGPointMake(41, 11.89))
        bezierPath.addCurveToPoint(CGPointMake(40.74, 15.32), controlPoint1: CGPointMake(41, 13.65), controlPoint2: CGPointMake(41, 14.53))
        bezierPath.addLineToPoint(CGPointMake(40.7, 15.47))
        bezierPath.addCurveToPoint(CGPointMake(38.47, 17.7), controlPoint1: CGPointMake(40.32, 16.51), controlPoint2: CGPointMake(39.51, 17.32))
        bezierPath.addCurveToPoint(CGPointMake(34.89, 18), controlPoint1: CGPointMake(37.53, 18), controlPoint2: CGPointMake(36.65, 18))
        bezierPath.addLineToPoint(CGPointMake(6.11, 18))
        bezierPath.addCurveToPoint(CGPointMake(2.68, 17.74), controlPoint1: CGPointMake(4.35, 18), controlPoint2: CGPointMake(3.47, 18))
        bezierPath.addLineToPoint(CGPointMake(2.53, 17.7))
        bezierPath.addCurveToPoint(CGPointMake(0.3, 15.47), controlPoint1: CGPointMake(1.49, 17.32), controlPoint2: CGPointMake(0.68, 16.51))
        bezierPath.addCurveToPoint(CGPointMake(0, 11.89), controlPoint1: CGPointMake(0, 14.53), controlPoint2: CGPointMake(0, 13.65))
        bezierPath.addLineToPoint(CGPointMake(0, 6.11))
        bezierPath.addCurveToPoint(CGPointMake(0.26, 2.68), controlPoint1: CGPointMake(0, 4.35), controlPoint2: CGPointMake(-0, 3.47))
        bezierPath.addLineToPoint(CGPointMake(0.3, 2.53))
        bezierPath.addCurveToPoint(CGPointMake(2.53, 0.3), controlPoint1: CGPointMake(0.68, 1.49), controlPoint2: CGPointMake(1.49, 0.68))
        bezierPath.addCurveToPoint(CGPointMake(6.11, 0), controlPoint1: CGPointMake(3.47, 0), controlPoint2: CGPointMake(4.35, 0))
        bezierPath.closePath()
        CGContextSaveGState(context!)
        CGContextSetShadowWithColor(context!, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
        
        UTBussesStyles.orange.setFill()
        bezierPath.fill()
        CGContextRestoreGState(context!)
        
        var timeStr = NSDateFormatter.localizedStringFromDate(time, dateStyle: .NoStyle, timeStyle: .ShortStyle)
        timeStr = timeStr.substringToIndex(timeStr.endIndex.predecessor().predecessor().predecessor())
        
        
        //// Text Drawing
        let textRect = CGRectMake(0, 1, 41, 14)
        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = .Center
        
        let textFontAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: UIFont.systemFontSize())!, NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: textStyle]
        
        let textTextHeight: CGFloat = NSString(string: timeStr).boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        CGContextSaveGState(context!)
        CGContextClipToRect(context!, textRect);
        NSString(string: timeStr).drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context!)
    }

}
