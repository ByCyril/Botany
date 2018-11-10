//
//  BotanyView.swift
//  Botany
//
//  Created by Cyril Garcia on 11/9/18.
//  Copyright © 2018 By Cyril. All rights reserved.
//

import UIKit

class BotanyView: UIView {
    
    private var imageView: UIImageView!
    private var cameraButton: UIButton!
    private var imageLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupview() {
        let width = self.frame.size.width
        let height = self.frame.size.height
        self.backgroundColor = UIColor.white
        self.imageView = {
            let cyRect = CYRect(width / 2, y: height * 0.35, width: width - 75, height: width - 75).rect
            let imageView = UIImageView(frame: cyRect)
            imageView.contentMode = .scaleAspectFill
            return imageView
        }()
        
        self.cameraButton = {
            let cyRect = CYRect(width / 2, y: height * 0.90, width: 150, height: 50).rect
            let button = UIButton(frame: cyRect)
            button.setTitle("Camera", for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.backgroundColor = UIColor.clear
            return button
        }()
        
        self.imageLabel = {
            let cyRect = CYRect(width / 2, y: height * 0.80, width: width, height: 100).rect
            let label = UILabel(frame: cyRect)
            label.textAlignment = .center
            label.textColor = UIColor.black
            label.backgroundColor = UIColor.clear
            return label
        }()
        
        self.addSubview(self.imageView)
        self.addSubview(self.cameraButton)
        self.addSubview(self.imageLabel)
    }
    
    public func setImage(_ image: UIImage) {
        self.imageView.image = image
    }
    
    public func setLabel(_ label: String) {
        self.imageLabel.text = label
    }
    
    public func setTarget(_ selector: Selector, target: UIViewController) {
        self.cameraButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
}
