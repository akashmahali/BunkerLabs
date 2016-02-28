//
//  DrawView.swift
//  Alchemy
//
//  Created by Akash on 17/02/16.
//  Copyright © 2016 Akash. All rights reserved.
//

import UIKit

let π = CGFloat(M_PI)

class DrawView: UIView {

    var startPoint = CGPoint()
    var endPoint = CGPoint()
    var points: [CGPoint] = []
    var hasTouchesEnded = false
    var contextImage:UIImage?
    var fillColor : UIColor =  UIColor.blackColor()

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        if points.count > 0 {
            drawMirrorShape(rect)

        }
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches{
            
            hasTouchesEnded = false
        
            points.append(touch.locationInView(self))
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches{
            
            
            points.append(touch.locationInView(self))
            
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches{
            
            points.append(touch.locationInView(self))
            hasTouchesEnded = true
            setNeedsDisplay()
        }
        
    }
    
    
    func drawLine(rect:CGRect?){
    
        let line = UIBezierPath()
        line.moveToPoint(startPoint)
        line.addLineToPoint(endPoint)
        line.lineWidth = 5.0
        line.stroke()
    }
    
    func drawCircle(rect: CGRect?){
        
        var center =  CGPoint()
        center.x = (endPoint.x - startPoint.x)/2 + startPoint.x
        center.y = (endPoint.y - startPoint.y)/2 + startPoint.y
    
        let circle = UIBezierPath(arcCenter: center, radius: (endPoint.x - startPoint.x)/2, startAngle: 0, endAngle: 2*π, clockwise: true)
        
        circle.lineWidth = 5.0
        UIColor.greenColor().setStroke()
        circle .stroke()
    }
    
    func drawShape(rect : CGRect?){
    
        
        if hasTouchesEnded == false {
        
            
            if let image = contextImage {
            
                UIColor(patternImage: image).setFill()
                CGContextFillRect(UIGraphicsGetCurrentContext(), rect!)
            }
            
            let shape = UIBezierPath()
            shape.lineWidth = 1.0;
            fillColor.setFill()
            shape.moveToPoint(points[0])
            
            for var i = 1; i < points.count; i++
            {
                shape.addLineToPoint(points[i])
            }
            
            shape.closePath()
            
            shape.fill()
        }else{
        
            UIGraphicsBeginImageContextWithOptions((rect?.size)!, true,0.0)
            
            let drawingContext = UIGraphicsGetCurrentContext()
                    
            UIColor.whiteColor().setFill()
            CGContextFillRect(drawingContext, rect!)
            
            if let image = contextImage {
                
                UIColor(patternImage: image).setFill()
                CGContextFillRect(drawingContext, rect!)
            }
            
            let shape = UIBezierPath()
            shape.lineWidth = 1.0;
            fillColor.setFill()
            shape.moveToPoint(points[0])
            
            for var i = 1; i < points.count; i++
            {
                shape.addLineToPoint(points[i])
            }
            
            shape.closePath()
            
            shape.fill()
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            contextImage = image
            UIGraphicsEndImageContext()
            
            UIColor(patternImage: image).setFill()
            CGContextFillRect(UIGraphicsGetCurrentContext(), rect!)
            
            points.removeAll()
        }
        
    }
    
    
    func drawMirrorShape(rect : CGRect?){
        
        
        if hasTouchesEnded == false {
            
            
            if let image = contextImage {
                
                UIColor(patternImage: image).setFill()
                CGContextFillRect(UIGraphicsGetCurrentContext(), rect!)
            }
            
            let shape = UIBezierPath()
            let mirrorShape = UIBezierPath()
            
            mirrorShape.lineWidth = 1.0
            shape.lineWidth = 1.0;
            
            fillColor.setFill()
            
            shape.moveToPoint(points[0])
            mirrorShape.moveToPoint(getMeMirrorPoint(points[0], rect: rect!))
            
            
            for var i = 1; i < points.count; i++
            {
                shape.addLineToPoint(points[i])
                mirrorShape.addLineToPoint(getMeMirrorPoint(points[i], rect: rect!))
            }
            
            shape.closePath()
            mirrorShape.closePath()
            
            shape.fill()
            mirrorShape.fill()
        }else{
            
            UIGraphicsBeginImageContextWithOptions((rect?.size)!, true,0.0)
            
            let drawingContext = UIGraphicsGetCurrentContext()
            
            UIColor.whiteColor().setFill()
            CGContextFillRect(drawingContext, rect!)
            
            if let image = contextImage {
                
                UIColor(patternImage: image).setFill()
                CGContextFillRect(drawingContext, rect!)
            }
            
            let shape = UIBezierPath()
            let mirrorShape = UIBezierPath()
            
            mirrorShape.lineWidth = 1.0
            shape.lineWidth = 1.0;
            
            fillColor.setFill()
            
            shape.moveToPoint(points[0])
            mirrorShape.moveToPoint(getMeMirrorPoint(points[0], rect: rect!))
            
            
            for var i = 1; i < points.count; i++
            {
                shape.addLineToPoint(points[i])
                mirrorShape.addLineToPoint(getMeMirrorPoint(points[i], rect: rect!))
            }
            
            shape.closePath()
            mirrorShape.closePath()
            
            shape.fill()
            mirrorShape.fill()
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            contextImage = image
            UIGraphicsEndImageContext()
            
            UIColor(patternImage: image).setFill()
            CGContextFillRect(UIGraphicsGetCurrentContext(), rect!)
            
            points.removeAll()
        }
        
    }
    
    func getMeMirrorPoint(point: CGPoint, rect: CGRect) -> CGPoint{
    
        let mirrorPoint : CGPoint = CGPointMake(rect.size.width - point.x, point.y)
        
        return mirrorPoint
    }

    
    @IBAction func changeColor(sender: AnyObject) {
        
        let button = sender as! UIButton
        
        if button.tag == 0{
            
            fillColor = UIColor.blackColor()
        
        }else if button.tag == 2 {
            
            fillColor = UIColor.whiteColor()
        
        }
        
    }
    
}
