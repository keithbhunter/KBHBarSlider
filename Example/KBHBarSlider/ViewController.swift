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
        
        self.barSlider.maximumValue = 100.0
        self.barSlider.value = 50.0
        self.barSlider.barColor = self.view.tintColor
        self.barSlider.addTarget(self, action: "barSliderValueChanged:", forControlEvents: .ValueChanged)
        self.label.text = "\(self.barSlider.value)"
    }
    
    
    // MARK: - Gesture
    
    func barSliderValueChanged(sender: KBHBarSlider) {
        self.label.text = "\(sender.value)"
    }

}

