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
            x = -0.2
        } else if intialPosition == "Center" {
            x = 0
        } else if intialPosition == "Right" {
            x = 0.2
        }
        
        var cubeSize: CGFloat = 0.33
        
        self.name = "cube"
        self.geometry = SCNBox (width: cubeSize, height: cubeSize, length: cubeSize, chamferRadius: cubeSize/5)
        self.position = SCNVector3(x,0.15,1.35)
        self.rotation = SCNVector4(Float(arc4random()%20),Float(arc4random()%20),Float(arc4random()%20),Float(arc4random()%20))

        
        
        
        
        
        let blueSide = SCNMaterial()
        blueSide.diffuse.contents = UIImage(named: "BlueCubeFace")
        blueSide.locksAmbientWithDiffuse = false
        
        let redSide = SCNMaterial()
        redSide.diffuse.contents = UIImage(named: "RedCubeFace")
        redSide.locksAmbientWithDiffuse = false
        
        let yellowSide = SCNMaterial()
        yellowSide.diffuse.contents = UIImage(named: "YellowCubeFace")
        yellowSide.locksAmbientWithDiffuse = false
        
        let greenSide = SCNMaterial()
        greenSide.diffuse.contents = UIImage(named: "GreenCubeFace")
        greenSide.locksAmbientWithDiffuse = false
        
        let purpleSide = SCNMaterial()
        purpleSide.diffuse.contents = UIImage(named: "PurpleCubeFace")
        purpleSide.locksAmbientWithDiffuse = false
        
        let cyanSide = SCNMaterial()
        cyanSide.diffuse.contents = UIImage(named: "CyanCubeFace")
        cyanSide.locksAmbientWithDiffuse = false
        
        
        let blackSide = SCNMaterial()
        blackSide.diffuse.contents = UIColor.blackColor()
        blackSide.locksAmbientWithDiffuse = false
        
        
        let cubeMass = CGFloat(10)
        let cubeRestitution = CGFloat(0.5)      //default 0.5
        let cubeAngularDamping = CGFloat(0.5)   //default 0.1
        let cubeRollingFriction = CGFloat(1.0)  //default 0.0
        let cubeFriction = CGFloat(0.5)         //default 0.0
        
        self.geometry!.materials = [greenSide, redSide, yellowSide, blueSide, purpleSide, cyanSide]
        self.physicsBody = SCNPhysicsBody.dynamicBody()
        self.physicsBody?.mass = cubeMass
        self.physicsBody?.restitution = cubeRestitution
        self.physicsBody?.angularDamping = cubeAngularDamping
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.rollingFriction = cubeRollingFriction
        self.physicsBody?.friction = cubeFriction
        
    }
    
}
