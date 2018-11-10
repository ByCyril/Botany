//
//  ViewController.swift
//  Botany
//
//  Created by Cyril Garcia on 3/7/18.
//  Copyright © 2018 By Cyril. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FlowersDelegate, CameraDelegate {

    var botanyView: BotanyView!
    var flowerModel: Flowers!
    
    private var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.botanyView = BotanyView(frame: self.view.frame)
        self.botanyView.setTarget(#selector(ViewController.showCamera), target: self)
        self.view.addSubview(self.botanyView)
        
        self.flowerModel = Flowers(Books().model)
        self.flowerModel.delegate = self
        
    }
    
    @objc func showCamera() {
        let camera = CameraController()
        camera.delegate = self
        self.present(camera, animated: true, completion: nil)
    }
    
    func getImage(_ image: UIImage) {
        self.flowerModel.predict(image)
        self.botanyView.setImage(image)
    }
    
    func flowerPrediction(_ name: String, _ confidenceLevel: Double) {
        self.botanyView.setLabel("Flower: \(name)\nConfidence Level: \(confidenceLevel)")
        print(confidenceLevel)
    }
}

