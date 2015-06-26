//
//  ViewController.swift
//  KBHBarSlider
//
//  Created by Keith Hunter on 5/1/15.
//  Copyright (c) 2015 Keith Hunter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var barSlider: KBHBarSlider!
    @IBOutlet weak var label: UILabel!
    
    
    // MARK: - UI Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.barSlider.backgroundColor = .lightGrayColor()
        self.barSlider.backgroundBarColor = .cyanColor()
        self.barSlider.barColor = .magentaColor()
        self.barSlider.barWidth = self.view.frame.size.width / 2.0
        self.barSlider.direction = .BottomToTop
        self.barSlider.alignment = .Center
        
        self.barSlider.minimumValue = 0
        self.barSlider.maximumValue = 100
        self.barSlider.value = 50
        
        self.barSlider.addTarget(self, action: "barSliderValueChanged:", forControlEvents: .ValueChanged)
        self.label.text = "\(self.barSlider.value)"
    }
    
    
    // MARK: - Gesture
    
    func barSliderValueChanged(sender: KBHBarSlider) {
        self.label.text = "\(Int(sender.value))"
    }

}

