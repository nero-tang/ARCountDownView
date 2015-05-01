//
//  ARCountDownView.swift
//  ARCountDownView
//
//  Created by Yufei Tang on 2015-04-30.
//  Copyright (c) 2015 Yufei Tang. All rights reserved.
//

import UIKit


/**
*  ARCountDownViewDelegate
*/

protocol ARCountDownViewDelegate: class {
    
    /**
    Delegate method when every second passed
    
    :param: countDownView countDownView
    :param: second        total second elapsed since start
    */
    func countDownView(countDownView: ARCountDownView, secondElapsed second: UInt, didFinish flag: Bool)
}


/**
*  ARCountDownView
*/
class ARCountDownView: UIView {
    
    /// Time to countdown, in second
    var duration: UInt! {
        didSet {
            textLabel.text = String(duration)
            //contentLayer.strokeStart = 0.05 / CGFloat(duration)
            contentLayer.lineDashPattern = lineDashPattern
        }
    }
    
    /// Countdown delegate
    weak var delegate: ARCountDownViewDelegate?
    
    /// Color of central text
    var textColor: UIColor! {
        set {
            textLabel.textColor = newValue
        }
        get {
            return textLabel.textColor
        }
    }
    
    /// Font of central text
    var font: UIFont! {
        set {
            textLabel.font = newValue
        }
        get {
            return textLabel.font
        }
    }
    
    /// Color of the animated ring
    var strokeColor: UIColor! {
        set {
            contentLayer.strokeColor = newValue.CGColor
        }
        get {
            return UIColor(CGColor: contentLayer.strokeColor)
        }
    }
    
    // MARK: - Initializers
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    /**
    *  Setup countdown view
    */
    private func setup() {
        duration = 10
        textColor = UIColor(red: 255 / 255.0, green: 94 / 255.0, blue: 58 / 255.0, alpha: 1.0)
        font = UIFont.boldSystemFontOfSize(16)
        strokeColor = UIColor(red: 90 / 255.0, green: 212 / 255.0, blue: 39 / 255.0, alpha: 1.0)
        contentLayer.contentsScale = UIScreen.mainScreen().scale
        contentLayer.fillColor = UIColor.clearColor().CGColor
        textLabel.textAlignment = .Center
        addSubview(textLabel)
    }
    
    func startAnimation() {
        /**
        *  If the countdown is not in progress, fire the timer
        */
        if !started {
            
            /**
            *  Reset time elapsed, in second
            */
            timeElapsed = 0
            
            /**
            *  Remove all previous animations
            */
            contentLayer.removeAllAnimations()
            
            /**
            *  Renew timer, update progress every second
            */
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "onSecondPassed", userInfo: nil, repeats: true)
            
            /**
            *  Reset central text
            */
            textLabel.text = String(duration)
            
            /**
            *  Start animation
            */
            updateCountDownAnimation()
            
            /**
            *  Reset flags
            */
            started = true
            counting = true
        }
    }
    
    /**
    *  Function to toggle between Pause & Counting
    */
    func pauseAnimation() {
        if started {
            counting = !counting
        }
    }
    
    
    /**
    *  Callback functions of timer, every second
    */
    func onSecondPassed() {
        if started && counting {
            started = ++timeElapsed < duration
            delegate?.countDownView(self, secondElapsed: timeElapsed, didFinish: !started)
            if !started {
                timer.invalidate()
                timer = nil
                counting = false
            } else {
                updateCountDownAnimation()
            }
        }
    }
    
    
    /**
    *  Function that updates the animation
    */
    func updateCountDownAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.delegate = self
        animation.duration = 0.9
        animation.fromValue = contentLayer.presentationLayer().strokeEnd
        animation.toValue = contentLayer.presentationLayer().strokeEnd - 1.0 / CGFloat(duration)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        contentLayer.addAnimation(animation, forKey: animation.keyPath)
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        let width = (2 * radius - lineWidth) / 1.414
        self.textLabel.frame.size = CGSizeMake(width, width)
        self.textLabel.center = arcCenter
        
        let size = String(duration).sizeWithAttributes([NSFontAttributeName: self.font])
        let pointPerPixel = self.font.pointSize / size.height
        let targetPointSize = pointPerPixel * width
        self.textLabel.font = UIFont(name: self.font.fontName, size: targetPointSize)
        
        /*
        *  Update the layout of content layer
        */
        contentLayer.path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(M_PI_2 * 3), clockwise: true).CGPath
        contentLayer.lineWidth = lineWidth
        contentLayer.lineDashPattern = lineDashPattern
    }
    
    
    
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        textLabel.text = String(duration - timeElapsed - 1)
    }
    
    
    // MARK: Private properties
    
    private var arcCenter: CGPoint {
        return CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds))
    }
    
    private var radius: CGFloat {
        return min(bounds.width, bounds.height) * 0.4
    }
    
    private var lineWidth: CGFloat {
        return min(bounds.width, bounds.height) * 0.15
    }
    
    private var lineDashPattern: [CGFloat] {
        let circumference = 2 * CGFloat(M_PI) * radius
        let sgmtLength = circumference / CGFloat(duration)
        return [sgmtLength * 0.95, sgmtLength * 0.05]
    }
    
    private var counting: Bool = false
    
    private var started: Bool = false
    
    private var timeElapsed: UInt = 0
    
    private var textLabel = UILabel()
    
    private var contentLayer: CAShapeLayer {
        return layer as! CAShapeLayer
    }
    
    private var timer: NSTimer!
    
    /**
    Override default layer class to CAShapeLayer
    
    :returns: Class of CAShapeLayer
    */
    override class func layerClass() -> AnyClass {
        return CAShapeLayer.self
    }
}
