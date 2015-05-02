//
//  KBHBarSlider.swift
//  KBHBarSlider
//
//  Created by Keith Hunter on 5/1/15.
//  Copyright (c) 2015 Keith Hunter. All rights reserved.
//
//  Governing Equations
//      Percentage (adjustedValue) from Value:  Percentage = (Value-Min) / (Max-Min)
//      Value from Percentage (adjustedValue):  Value = Percentage(Max-Min) + Min
//

import UIKit

public let KBHBarSliderBarWidthNotSet: CGFloat = -1.0


/**
Describes the way the bar will be draw from the minimum value to the maximum value.

- LeftToRight: Minimum value will be on the left; maximum value on the right.
- RightToLeft: Minimum value will be on the right; maximum value on the left.
- TopToBottom: Minimum value will be on the top; maximum value on the bottom.
- BottomToTop: Minimum value will be on the bottom; maximum value on the top.
*/
public enum KBHBarSliderDirection {
    case LeftToRight
    case RightToLeft
    case TopToBottom
    case BottomToTop
}


public class KBHBarSlider: UIControl {
    
    // MARK: - Backing Variables
    // TODO: Is there a better way than backing variables and properties?
    
    private var _value: CGFloat = 0.5
    private var _minimumValue: CGFloat = 0.0
    private var _maximumValue: CGFloat = 1.0
    private var _barWidth: CGFloat = KBHBarSliderBarWidthNotSet
    
    /// self.value is in range self.minimum - self.maximum. _adjustedValue is value as a percentage of the min/max, between 0.0 - 1.0. See the governing equations at the top of the file.
    private var _adjustedValue: CGFloat {
        get {
            return (self.value - self.minimumValue) / (self.maximumValue - self.minimumValue)
        }
        set {
            self.value = (newValue * (self.maximumValue - self.minimumValue)) + self.minimumValue
        }
    }
    
    
    // MARK: - Properties
    
    /// Current value of the bar slider. Defaults to 0.5.
    public var value: CGFloat {
        get {
            return _value
        }
        set {
            if newValue > self.maximumValue {
                _value = self.maximumValue
            } else if (newValue < self.minimumValue) {
                _value = self.minimumValue
            } else {
                _value = newValue
            }
            
            self.setNeedsDisplay()
            self.sendActionsForControlEvents(.ValueChanged)
        }
    }
    
    /// Minimum value the bar slider will allow. Defaults to 0.
    public var minimumValue: CGFloat {
        get {
            return _minimumValue
        }
        set {
            _minimumValue = newValue
            
            if newValue > self.maximumValue {
                self.maximumValue = newValue
            }
            
            if newValue > self.value {
                self.value = newValue
            }
            
            self.setNeedsDisplay()
        }
    }
    
    /// Maximum value the bar slider will allow. Defaults to 1.
    public var maximumValue: CGFloat {
        get {
            return _maximumValue
        }
        set {
            _maximumValue = newValue
            
            if newValue < self.minimumValue {
                self.minimumValue = newValue
            }
            
            if newValue < self.value {
                self.value = newValue
            }
            
            self.setNeedsDisplay()
        }
    }
    
    /// The color of the bar that will be sliding (foreground bar/sliding bar). Defaults to UIColor.blueColor().
    public var barColor: UIColor = .blueColor() {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    /// The color of the bar that will act as a track for the foreground bar to slide on. Defaults to UIColor.lightGrayColor().
    public var backgroundBarColor: UIColor = .lightGrayColor() {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    /// The width of the bar slider. Must be between 0 and the view's width. Defaults to the view's width
    public var barWidth: CGFloat {
        get {
            return (_barWidth == KBHBarSliderBarWidthNotSet) ? self.bounds.size.width : _barWidth
        }
        set {
            _barWidth = newValue
            
            if newValue <= 0.0 {
                _barWidth = 1.0
            }
            
            if newValue > self.bounds.size.width {
                _barWidth = self.bounds.size.width
            }
            
            self.setNeedsDisplay()
        }
    }
    
    /// The direction the sliding bar will be drawn. Defaults to KBHBarSliderDirection.BottomToTop.
    public var direction: KBHBarSliderDirection = .BottomToTop
    
    
    // MARK: - Init

    public init() {
        super.init(frame: CGRectZero)
        self.setup()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    private func setup() {
        let panGesture = UIPanGestureRecognizer(target: self, action: "viewDidPan:")
        self.gestureRecognizers = [panGesture]
    }

    
    // MARK: - Drawing
    
    override public func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, self.barWidth)
        
        // Draw background bar
        self.backgroundBarColor.setStroke()
        self.drawBarToPercentage(1.0, inContext: context)
        
        // Draw sliding bar
        self.barColor.setStroke()
        self.drawBarToPercentage(_adjustedValue, inContext: context)
    }
    
    private func drawBarToPercentage(percent: CGFloat, inContext context: CGContext) {
        CGContextBeginPath(context)
        
        switch self.direction {
        case .BottomToTop: self.drawBarBottomToTopWithPercentage(percent, inContext: context); break
        case .TopToBottom: self.drawBarTopToBottomWithPercentage(percent, inContext: context); break
        case .LeftToRight: self.drawBarLeftToRightWithPercentage(percent, inContext: context); break
        case .RightToLeft: self.drawBarRightToLeftWithPercentage(percent, inContext: context); break
        default: break
        }
        
        CGContextStrokePath(context)
    }
    
    private func drawBarBottomToTopWithPercentage(percent: CGFloat, inContext context: CGContext) {
        let centerOfBar = self.bounds.origin.x + (self.bounds.size.width / 2.0)
        CGContextMoveToPoint(context, centerOfBar, self.bounds.origin.y + self.bounds.size.height)
        CGContextAddLineToPoint(context, centerOfBar, self.bounds.origin.y + (self.bounds.size.height * (1.0 - percent)))
    }
    
    private func drawBarTopToBottomWithPercentage(percent: CGFloat, inContext context: CGContext) {
        let centerOfBar = self.bounds.origin.x + (self.bounds.size.width / 2.0)
        CGContextMoveToPoint(context, centerOfBar, self.bounds.origin.y)
        CGContextAddLineToPoint(context, centerOfBar, self.bounds.origin.y + (self.bounds.size.height * percent))
    }
    
    private func drawBarLeftToRightWithPercentage(percent: CGFloat, inContext context: CGContext) {
        let centerOfBar = self.bounds.origin.y + (self.bounds.size.height / 2.0)
        CGContextMoveToPoint(context, self.bounds.origin.x, centerOfBar)
        CGContextAddLineToPoint(context, self.bounds.origin.x + (self.bounds.size.width * percent), centerOfBar)
    }
    
    private func drawBarRightToLeftWithPercentage(percent: CGFloat, inContext context: CGContext) {
        let centerOfBar = self.bounds.origin.y + (self.bounds.size.height / 2.0)
        CGContextMoveToPoint(context, self.bounds.origin.x + self.bounds.size.width, centerOfBar)
        CGContextAddLineToPoint(context, self.bounds.origin.x + (self.bounds.size.width * (1.0 - percent)), centerOfBar)
    }
    
    
    // MARK: - Gesture Recognizer
    
    internal func viewDidPan(panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .Began:
            self.sendActionsForControlEvents(.TouchDown)
            break
        case .Changed:
            // TODO: Find a better way to persist the previous point
            struct PersistentPoint {
                static var point: CGPoint = CGPointZero
            }
            
            let point = panGesture.locationInView(self)
            _adjustedValue = self.adjustedValueForPointInView(point: point)  // This will trigger drawRect(...)
            
            if (!CGRectContainsPoint(self.bounds, PersistentPoint.point) && CGRectContainsPoint(self.bounds, point)) {
                self.sendActionsForControlEvents(.TouchDragEnter)
            } else if (CGRectContainsPoint(self.bounds, PersistentPoint.point) && !CGRectContainsPoint(self.bounds, point)) {
                self.sendActionsForControlEvents(.TouchDragExit)
            } else if (CGRectContainsPoint(self.bounds, PersistentPoint.point) && CGRectContainsPoint(self.bounds, point)) {
                self.sendActionsForControlEvents(.TouchDragInside)
            } else {
                self.sendActionsForControlEvents(.TouchDragOutside)
            }
            
            PersistentPoint.point = point
            break
        case .Ended:
            self.sendActionsForControlEvents(.TouchUpInside)
            break
        default:
            break
        }
    }
    
    private func adjustedValueForPointInView(#point: CGPoint) -> CGFloat {
        switch self.direction {
        case .BottomToTop: return 1.0 - (point.y / self.bounds.size.height)
        case .TopToBottom: return point.y / self.bounds.size.height
        case .LeftToRight: return point.x / self.bounds.size.width
        case .RightToLeft: return 1.0 - (point.x / self.bounds.size.width)
        default: return 0.0
        }
    }
    
}
