//
//  Flowers.swift
//  Botany
//
//  Created by Cyril Garcia on 11/9/18.
//  Copyright © 2018 By Cyril. All rights reserved.
//

import UIKit
import Vision

protocol FlowersDelegate {
    func flowerPrediction(_ name: String, _ confidenceLevel: Double)
}

class ImageRecognition {
    
    public var delegate: FlowersDelegate!
    
    private var model: VNCoreMLModel!
    
    init(_ model: MLModel) {
        do {
            self.model = try VNCoreMLModel(for: model)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func predict(_ image: UIImage) {
        
        let pixelBuffer = ImageProcessor.pixelBuffer(forImage: image.cgImage!)
        
        let request = VNCoreMLRequest(model: self.model) { (req, err) in
            
            if err == nil {
                let results = req.results as? [VNClassificationObservation]
                let firstObservation = results!.first
            
                let label = firstObservation!.identifier
                let confidenceLebel = Double(firstObservation!.confidence)
                self.delegate.flowerPrediction(label, confidenceLebel)
                
            }
        }
        
        do {
            try VNImageRequestHandler(cvPixelBuffer: pixelBuffer!, options: [:]).perform([request])
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    
}



