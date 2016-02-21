//
//  CubeMaker.swift
//  cubeThrow
//
//  Created by Joseph Pelina on 2/18/16.
//  Copyright © 2016 redgarage. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class CubeMaker:SCNNode {
    
    convenience init(intialPosition: String) {
        self.init()
        
        var x: CGFloat = 0
        
        if intialPosition == "Left" {
            x = -0.1
        } else if intialPosition == "Center" {
            x = 0
        } else if intialPosition == "Right" {
            x = 0.1
        }
        
        self.geometry = SCNBox (width: 0.3, height: 0.3, length: 0.3, chamferRadius: 0.06) //0.3 to 0.06
        self.position = SCNVector3(x,0.15,1.35)
        self.name = "cube"
    }
    
}
