//
//  Palette.swift
//  project1
//
//  Created by JT Newsome on 2/8/16.
//  Copyright © 2016 JT Newsome. All rights reserved.
//

import UIKit

class Palette: UIControl {
    
    private var _lineWidth: CGFloat = 25.0
    private var _lineCap: CGLineCap = .Round
    private var _lineJoin: CGLineJoin = .Round
    private var _colorSelectorPos: CGPoint = CGPoint(x: 150.0, y: 112.5)
    private var _colorSeleced: UIColor = UIColor.greenColor()
    
    override func drawRect(rect: CGRect) {
        
        // Call parent function
        super.drawRect(rect)
        
        // Setup context
        let context: CGContext? = UIGraphicsGetCurrentContext()
        
        // Setup background gradient
        var colors = [UIColor.grayColor().CGColor, UIColor.whiteColor().CGColor]
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        var colorLocations:[CGFloat] = [0.0, 1]
        var gradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)
        var startPoint = CGPoint(x: 0.0, y: 0.0)
        var endPoint = CGPoint(x: rect.maxX, y: rect.maxY)
        
        // Draw background gradient
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, [])
        
        // Define rectangle to contain the palette
        let radius: CGFloat = 50.0;
        let paletteRect: CGRect = CGRectMake(radius, radius*0.25, bounds.width - radius * 2, bounds.width - radius * 2)
        
        // Define an area for palette
        let path = UIBezierPath(ovalInRect: paletteRect)
        CGContextSaveGState(context)
        path.addClip()
        
        // Setup palette gradient
        colors = [UIColor.redColor().CGColor, UIColor.orangeColor().CGColor, UIColor.yellowColor().CGColor, UIColor.greenColor().CGColor, UIColor.blueColor().CGColor, UIColor.purpleColor().CGColor]
        colorSpace = CGColorSpaceCreateDeviceRGB()
        colorLocations = [0.0, 0.16, 0.33, 0.5, 0.66, 0.83, 1]
        gradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)
        startPoint = CGPoint(x: path.bounds.midX, y: path.bounds.minY)
        endPoint = CGPoint(x: path.bounds.midX, y: path.bounds.maxY)
        
        // Draw palette gradient
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, [])
        
        // Setup color selector
        let colorSelectRadius: CGFloat = 20.0
        let colorSelect = CGRectMake(_colorSelectorPos.x, _colorSelectorPos.y, colorSelectRadius, colorSelectRadius)
        CGContextSetLineWidth(context, 1.5)
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextSetAlpha(context, 0.35)
        CGContextAddEllipseInRect(context, colorSelect)
        
        // Draw color selector
        CGContextStrokePath(context)
        
        // Restore to pre-clipping state so we can draw elsewhere
        CGContextRestoreGState(context)
        
        // Setup "preview"
        CGContextMoveToPoint(context, 50.0, 470.0)
        CGContextAddLineToPoint(context, 50.0, 430.0)
        CGContextAddLineToPoint(context, 70.0, 455.0)
        CGContextAddLineToPoint(context, 100.0, 440.0)
        CGContextAddLineToPoint(context, 150.0, 470.0)
        CGContextAddLineToPoint(context, 220.0, 430.0)
        CGContextAddLineToPoint(context, 230.0, 440.0)
        CGContextAddLineToPoint(context, 260.0, 440.0)
        CGContextAddLineToPoint(context, rect.maxX - 50, 470.0)
        CGContextSetStrokeColorWithColor(context, _colorSeleced.CGColor)
        CGContextSetLineWidth(context, _lineWidth)      // 0.0 - 50.0
        CGContextSetLineCap(context, _lineCap)          // Butt  | Round | Square
        CGContextSetLineJoin(context, _lineJoin)        // Miter | Round | Bevel

        // Draw "preview"
        CGContextStrokePath(context)
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.locationInView(self)
        
        if (isInColorPalette(touchPoint)) {
            _colorSelectorPos = touchPoint
            
            let color:UIColor = getPixelColorAtPoint(touchPoint)
            colorSelected = color
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.locationInView(self)
        
        if (isInColorPalette(touchPoint)) {
            _colorSelectorPos = touchPoint
            
            let color:UIColor = getPixelColorAtPoint(touchPoint)
            colorSelected = color
        }
        
    }
    
    func isInColorPalette(point: CGPoint)->Bool {
        let lhs: CGFloat = sqrt(abs(point.x - 150.0) * abs(point.x - 150.0) + abs(point.y - 112.5) * abs(point.y - 112.5))
        let rhs: CGFloat = 110.0
        if (lhs < rhs) {
            return true
        }
        else {
            return false
        }
    }
    
    // Returns the color data of the pixel at the currently selected point
    func getPixelColorAtPoint(point:CGPoint)->UIColor
    {
        let pixel = UnsafeMutablePointer<CUnsignedChar>.alloc(4)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
        let context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, bitmapInfo.rawValue)
        
        CGContextTranslateCTM(context, -point.x, -point.y)
        layer.renderInContext(context!)
        let color:UIColor = UIColor(red: CGFloat(pixel[0])/255.0, green: CGFloat(pixel[1])/255.0, blue: CGFloat(pixel[2])/255.0, alpha: CGFloat(pixel[3])/255.0)
        
        pixel.dealloc(4)
        return color
    }
    
    var lineWidth: CGFloat {
        get {
            return _lineWidth
        }
        set {
            _lineWidth = newValue
            setNeedsDisplay()
        }
    }
    
    var lineCap: CGLineCap {
        get {
            return _lineCap
        }
        set {
            _lineCap = newValue
            setNeedsDisplay()
        }
    }
    
    var lineJoin: CGLineJoin {
        get {
            return _lineJoin
        }
        set {
            _lineJoin = newValue
            setNeedsDisplay()
        }
    }
    
    var colorSelectorPos: CGPoint {
        get {
            return _colorSelectorPos
        }
        set {
            _colorSelectorPos = newValue
            setNeedsDisplay()
        }
    }
    
    var colorSelected: UIColor {
        get {
            return _colorSeleced
        }
        set {
            _colorSeleced = newValue
            sendActionsForControlEvents(.ValueChanged)
            setNeedsDisplay()
        }
    }
    
}
