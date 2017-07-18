//
//  SignView.swift
//  sign
//
//  Created by imac on 17/7/18.
//  Copyright © 2017年 Guowu. All rights reserved.
//

import UIKit

open class SignView: UIView {

    //公共属性
    open var lineWidth: CGFloat = 2.0 {
        
        didSet {
            self.path.lineWidth = lineWidth
        }
    }
    open var strokeColor: UIColor = UIColor.black
    open var signatureBackGroundColor: UIColor = UIColor.white
    
    //私有属性
    fileprivate var path = UIBezierPath()
    fileprivate var pts = [CGPoint](repeating: CGPoint(), count: 5)
    fileprivate var ctr = 0
    
    //Int
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = self.signatureBackGroundColor
        self.path.lineWidth = self.lineWidth
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = self.signatureBackGroundColor
        self.path.lineWidth = lineWidth
        fatalError("init(coder:) has not been implemented")
    }
    
    //Draw
    override open func draw(_ rect: CGRect) {
        self.strokeColor.setStroke()
        self.path.stroke()
    }
    
    //触摸签名相关的方法
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            let touchPoint = firstTouch.location(in: self)
            self.ctr = 0
            self.pts[0] = touchPoint
        }
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            let touchPoint = firstTouch.location(in: self)
            self.ctr += 1
            self.pts[self.ctr] = touchPoint
            if self.ctr == 4 {
                self.pts[3] = CGPoint.init(x: (self.pts[2].x + self.pts[4].x)/2.0, y: (self.pts[2].y + self.pts[4].y)/2.0)
                self.path.move(to: self.pts[0])
                self.path.addCurve(to: self.pts[3], controlPoint1: self.pts[1], controlPoint2: self.pts[2])
                
                self.setNeedsDisplay()
                self.pts[0] = self.pts[3]
                self.pts[1] = self.pts[4]
                self.ctr = 1
            }
            self.setNeedsDisplay()
            
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.ctr == 0 {
            let touchPoint = self.pts[0]
            self.path.move(to: CGPoint.init(x: touchPoint.x-1.0, y: touchPoint.y))
            self.path.addLine(to: CGPoint.init(x: touchPoint.x+1.0, y: touchPoint.y))
            
        }else{
            self.ctr = 0
        }
    }
    
    //签名视图清空
    open func clearSignature(){
        self.path.removeAllPoints()
        self.setNeedsDisplay()
    }
    
    //签名保存为UIImage
    open func getSignature() -> UIImage{
        UIGraphicsBeginImageContext(CGSize.init(width: self.bounds.size.width, height: self.bounds.size.height))
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let sinature: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return sinature
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
