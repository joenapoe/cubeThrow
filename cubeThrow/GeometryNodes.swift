//
//  GeometryNodes.swift
//  cubeThrow
//
//  Created by Joseph Pelina on 2/16/16.
//  Copyright © 2016 redgarage. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GeometryNodes {
    
    var planeScalar: CGFloat = 2
    
    let cube1 = CubeMaker(intialPosition: "Left")
    let cube2 = CubeMaker(intialPosition: "Center")
    let cube3 = CubeMaker(intialPosition: "Right")
    
    let boardFloor = SCNNode()
    
    
    
    
    init () {
        
        boardFloor.geometry = SCNBox(width: 2, height: 0.5, length: 4, chamferRadius: 0)
        boardFloor.position = SCNVector3(0,0,0)
        
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
        
        cube1.geometry!.materials = [greenSide, redSide, yellowSide, blueSide, purpleSide, cyanSide]
        cube1.physicsBody = SCNPhysicsBody.dynamicBody()
        cube1.physicsBody?.mass = cubeMass
        cube1.physicsBody?.restitution = cubeRestitution
        cube1.physicsBody?.angularDamping = cubeAngularDamping
        cube1.physicsBody?.affectedByGravity = true
        
        cube1.rotation = SCNVector4(Float(arc4random()%20),Float(arc4random()%20),Float(arc4random()%20),Float(arc4random()%20))
        cube1.physicsBody?.rollingFriction = cubeRollingFriction
//        cube1.physicsBody?.applyForce(SCNVector3(0,5,5), impulse: true)
        
        cube2.geometry!.materials = [greenSide, redSide, yellowSide, blueSide, purpleSide,cyanSide]
        cube2.physicsBody = SCNPhysicsBody.dynamicBody()
        cube2.physicsBody?.mass = cubeMass
        cube2.physicsBody?.restitution = cubeRestitution
        cube2.physicsBody?.angularDamping = cubeAngularDamping
        cube2.rotation = SCNVector4(Float(arc4random()%20),Float(arc4random()%20),Float(arc4random()%20),Float(arc4random()%20))

        cube2.physicsBody?.affectedByGravity = true

        
        
        cube3.geometry!.materials = [greenSide, redSide, yellowSide, blueSide, purpleSide,cyanSide]
        cube3.physicsBody = SCNPhysicsBody.dynamicBody()
        cube3.physicsBody?.mass = cubeMass
        cube3.physicsBody?.restitution = cubeRestitution
        cube3.physicsBody?.angularDamping = cubeAngularDamping
        cube3.rotation = SCNVector4(Float(arc4random()%20),Float(arc4random()%20),Float(arc4random()%20),Float(arc4random()%20))

        cube3.physicsBody?.affectedByGravity = true


        
        let floorMaterial = SCNMaterial()
        floorMaterial.diffuse.contents = UIImage(named: "BetoBlueBoard")!
        floorMaterial.locksAmbientWithDiffuse = false
        boardFloor.geometry!.materials = [blackSide, blackSide, blackSide, blackSide, floorMaterial, blackSide]
        boardFloor.physicsBody = SCNPhysicsBody.staticBody()
    }
    
    func getPhysicsPlane() -> SCNGeometry {
//        return SCNPlane(width: planeScalar*2, height: planeScalar*2)
        return SCNBox(width: planeScalar*2, height: planeScalar*2, length: 0.05, chamferRadius: 0)
    }
    
    func getPlanePhysicsBody() -> SCNPhysicsBody {
        let physBody = SCNPhysicsBody(type: SCNPhysicsBodyType.Kinematic, shape: SCNPhysicsShape(geometry: getPhysicsPlane(), options: nil))
        physBody.mass = 1000
        return physBody
    }
    
    
    func addNodesTo(parentNode:SCNNode) {

        parentNode.addChildNode(cube1)
        parentNode.addChildNode(cube2)
        parentNode.addChildNode(cube3)
        parentNode.addChildNode(boardFloor)
        
    }
    
}