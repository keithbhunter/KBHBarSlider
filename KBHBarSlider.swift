//
//  KBHBarSlider.swift
//  KBHBarSlider
//
//  Created by Keith Hunter on 5/1/15.
//  Copyright (c) 2015 Keith Hunter. All rights reserved.
//

import UIKit

public class KBHBarSlider: UIControl {
    
    // MARK: - Backing Variables
    // TODO: Is there a better way than backing variables and properties?
    
    private var _value: CGFloat = 0.5
    private var _minimumValue: CGFloat = 0.0
    private var _maximumValue: CGFloat = 1.0
    
    
    // MARK: - Properties
    
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
    
    public var minimumValue: CGFloat {
        get {
            return _minimumValue
        }
        set {
            _minimumValue = newValue
            
            if newValue > self.maximumValue {
                _minimumValue = self.maximumValue
            }
            
            if newValue > self.value {
                self.value = newValue
            }
            
            self.setNeedsDisplay()
        }
    }
    
    public var maximumValue: CGFloat {
        get {
            return _maximumValue
        }
        set {
            _maximumValue = newValue
            
            if newValue < self.minimumValue {
                _maximumValue = self.minimumValue
            }
            
            if newValue < self.value {
                self.value = newValue
            }
            
            self.setNeedsDisplay()
        }
    }
    
    public var barColor: UIColor = .blueColor() {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    
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
        CGContextSetLineWidth(context, self.frame.size.width)
        
        if let backgroundColor = self.backgroundColor {
            // backgroundColor could be nil, which would be transparent
            backgroundColor.setStroke()
            self.drawBarToPercentage(1.0, inContext: context)
        }
        
        self.barColor.setStroke()
        self.drawBarToPercentage(self.value / self.maximumValue, inContext: context)
    }
    
    private func drawBarToPercentage(percent: CGFloat, inContext context: CGContext) {
        CGContextBeginPath(context)
        let centerOfBar = self.bounds.origin.x + (self.bounds.size.width / 2.0)
        CGContextMoveToPoint(context, centerOfBar, self.bounds.origin.y + self.bounds.size.height)
        CGContextAddLineToPoint(context, centerOfBar, self.bounds.origin.y + (self.bounds.size.height * (1.0 - percent)))
        CGContextStrokePath(context)
    }
    
    
    // MARK: - Gesture Recognizer
    
    internal func viewDidPan(panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .Began:
            self.sendActionsForControlEvents(.TouchDown)
            break;
        case .Changed:
            // TODO: Find a better way to persist the previous point
            struct PersistentPoint {
                static var point: CGPoint = CGPointZero
            }
            
            let point = panGesture.locationInView(self)
            self.value = (1.0 - (point.y / self.bounds.height)) * self.maximumValue
            
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
            break;
        case .Ended:
            self.sendActionsForControlEvents(.TouchUpInside)
            break;
        default:
            break;
        }
    }
    
}
