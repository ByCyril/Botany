//
//  ViewController.swift
//  Botany
//
//  Created by Cyril Garcia on 3/7/18.
//  Copyright © 2018 By Cyril. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FlowersDelegate {

    let model = Flowers(Flower().model)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    func flowerPrediction(_ name: String, _ confidenceLevel: Double) {
        
    }
}

