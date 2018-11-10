//
//  CustomClass.swift
//  Botany
//
//  Created by Cyril Garcia on 11/9/18.
//  Copyright © 2018 By Cyril. All rights reserved.
//

import UIKit

struct CYRect {
    private var x: CGFloat!
    private var y: CGFloat!
    private var width: CGFloat!
    private var height: CGFloat!
    
    init(_ x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)  {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
    
    var rect: CGRect {
        return CGRect(x: self.x - (self.width / 2), y: self.y - (self.height / 2), width: self.width, height: self.height)
    }
    
}
