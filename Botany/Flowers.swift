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

class Flowers {
    
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
        
        let pixelBuffer = image.buffer(with: CGSize(width: 224, height: 224))
        
        let request = VNCoreMLRequest(model: self.model) { (req, err) in
            
            if err == nil {
                let results = req.results as? [VNClassificationObservation]
                let firstObservation = results!.first
                
                for r in results! {
                    print(r.identifier, Double(r.confidence))
                }
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



extension UIImage {
    func buffer(with size:CGSize) -> CVPixelBuffer? {
        if let image = self.cgImage {
            let frameSize = size
            var pixelBuffer:CVPixelBuffer? = nil
            let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(frameSize.width), Int(frameSize.height), kCVPixelFormatType_32BGRA , nil, &pixelBuffer)
            if status != kCVReturnSuccess {
                return nil
            }
            CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags.init(rawValue: 0))
            let data = CVPixelBufferGetBaseAddress(pixelBuffer!)
            let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
            let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
            let context = CGContext(data: data, width: Int(frameSize.width), height: Int(frameSize.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: bitmapInfo.rawValue)
            context?.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
            CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
            
            return pixelBuffer
        }else{
            return nil
        }
    }
}

