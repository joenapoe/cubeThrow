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
        
        let blackSide = SCNMaterial()
        blackSide.diffuse.contents = UIColor.blackColor()
        blackSide.locksAmbientWithDiffuse = false
    
        let floorMaterial = SCNMaterial()
        floorMaterial.diffuse.contents = UIImage(named: "BetoBlueBoard")!
        floorMaterial.locksAmbientWithDiffuse = false

        boardFloor.geometry = SCNBox(width: 2, height: 0.5, length: 4, chamferRadius: 0)
        boardFloor.position = SCNVector3(0,0,0)
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