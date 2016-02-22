//
//  GameScene.swift
//  cubeThrow
//
//  Created by Joseph Pelina on 2/16/16.
//  Copyright © 2016 redgarage. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameScene: SCNScene, SCNSceneRendererDelegate {
    
    var geometryNodes = GeometryNodes()
    
    convenience init(create: Bool) {
        
        self.init()
        
        let emptyTarget = SCNNode()
        emptyTarget.position = SCNVector3(0,0.15,0)

        let floor = SCNFloor()
        
        floor.firstMaterial!.diffuse.contents = UIColor.blackColor()
        floor.firstMaterial!.specular.contents = UIColor.blackColor()
        floor.firstMaterial!.reflective.contents = UIColor.blackColor()
        
        let floorNode = SCNNode(geometry: floor)
        floorNode.physicsBody = SCNPhysicsBody.staticBody()
        rootNode.addChildNode(floorNode)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
//        cameraNode.camera!.usesOrthographicProjection = true
//        cameraNode.position = SCNVector3Make(0, 0.5, 2)
//        cameraNode.rotation = SCNVector4(2,0,0, Float(-M_PI / 16.0))

        cameraNode.position = SCNVector3Make(0, 3.7, 0);
        cameraNode.eulerAngles = SCNVector3Make(Float(-M_PI/2), 0, 0);
        
        
        rootNode.addChildNode(cameraNode)
        
        
//        let lightNodeOmi = SCNNode()
//        lightNodeOmi.light = SCNLight()
//        lightNodeOmi.light!.type = SCNLightTypeAmbient
//        lightNodeOmi.position = SCNVector3(0,20,30)
//        rootNode.addChildNode(lightNodeOmi)
        
        let lightNodeSpot = SCNNode()
        lightNodeSpot.light = SCNLight()
        lightNodeSpot.light!.type = SCNLightTypeSpot
        lightNodeSpot.light!.attenuationStartDistance = 0
        lightNodeSpot.light!.attenuationFalloffExponent = 1
        lightNodeSpot.light!.attenuationEndDistance = 50
        lightNodeSpot.position = SCNVector3(0,10,0)
        lightNodeSpot.constraints = [SCNLookAtConstraint(target: emptyTarget)]
        rootNode.addChildNode(lightNodeSpot)

        let lightNodeSpotLeft = SCNNode()
        lightNodeSpotLeft.light = SCNLight()
        lightNodeSpotLeft.light!.type = SCNLightTypeSpot
        lightNodeSpotLeft.light!.attenuationStartDistance = 0
        lightNodeSpotLeft.light!.attenuationFalloffExponent = 1
        lightNodeSpotLeft.light!.attenuationEndDistance = 15
        lightNodeSpotLeft.position = SCNVector3(-10,0,0)
        lightNodeSpotLeft.constraints = [SCNLookAtConstraint(target: emptyTarget)]
        rootNode.addChildNode(lightNodeSpotLeft)
        
        let lightNodeSpotRight = SCNNode()
        lightNodeSpotRight.light = SCNLight()
        lightNodeSpotRight.light!.type = SCNLightTypeSpot
        lightNodeSpotRight.light!.attenuationStartDistance = 0
        lightNodeSpotRight.light!.attenuationFalloffExponent = 1
        lightNodeSpotRight.light!.attenuationEndDistance = 15
        lightNodeSpotRight.position = SCNVector3(10,0,0)
        lightNodeSpotRight.constraints = [SCNLookAtConstraint(target: emptyTarget)]
        rootNode.addChildNode(lightNodeSpotRight)
        
        let lightNodeSpotBack = SCNNode()
        lightNodeSpotBack.light = SCNLight()
        lightNodeSpotBack.light!.type = SCNLightTypeSpot
        lightNodeSpotBack.light!.attenuationStartDistance = 0
        lightNodeSpotBack.light!.attenuationFalloffExponent = 1
        lightNodeSpotBack.light!.attenuationEndDistance = 15
        lightNodeSpotBack.position = SCNVector3(0,10,0)
        lightNodeSpotBack.constraints = [SCNLookAtConstraint(target: emptyTarget)]
        rootNode.addChildNode(lightNodeSpotBack)
        
        let lightNodeSpotFront = SCNNode()
        lightNodeSpotFront.light = SCNLight()
        lightNodeSpotFront.light!.type = SCNLightTypeSpot
        lightNodeSpotFront.light!.attenuationStartDistance = 0
        lightNodeSpotFront.light!.attenuationFalloffExponent = 1
        lightNodeSpotFront.light!.attenuationEndDistance = 15
        lightNodeSpotFront.position = SCNVector3(0,-10,0)
        lightNodeSpotFront.constraints = [SCNLookAtConstraint(target: emptyTarget)]
        rootNode.addChildNode(lightNodeSpotFront)
        
        
        let invisiPlane = geometryNodes.getPhysicsPlane()
        let planePositionScalar = Float(geometryNodes.planeScalar)
        let planeOpacity:CGFloat = 0.0
        
        let invisiPlaneFront = SCNNode(geometry: invisiPlane)
        invisiPlaneFront.opacity = planeOpacity
        invisiPlaneFront.position = SCNVector3(0,0,0.9*planePositionScalar)
        invisiPlaneFront.physicsBody = geometryNodes.getPlanePhysicsBody()
        rootNode.addChildNode(invisiPlaneFront)
        
        let invisiPlaneLeft = SCNNode(geometry: invisiPlane)
        invisiPlaneLeft.opacity = planeOpacity
        invisiPlaneLeft.position = SCNVector3(-planePositionScalar/2,0,0)
        invisiPlaneLeft.rotation = SCNVector4(0,1,0,Float(M_PI_2))
        invisiPlaneLeft.physicsBody = geometryNodes.getPlanePhysicsBody()
        rootNode.addChildNode(invisiPlaneLeft)
        
        let invisiPlaneRight = SCNNode(geometry: invisiPlane)
        invisiPlaneRight.opacity = planeOpacity
        invisiPlaneRight.position = SCNVector3(planePositionScalar/2,0,0)
        invisiPlaneRight.rotation = SCNVector4(0,1,0,Float(-M_PI_2))
        invisiPlaneRight.physicsBody = geometryNodes.getPlanePhysicsBody()
        rootNode.addChildNode(invisiPlaneRight)
        
        let invisiPlaneBack = SCNNode(geometry: invisiPlane)
        invisiPlaneBack.opacity = planeOpacity
        invisiPlaneBack.position = SCNVector3(0,0,-0.85*planePositionScalar)
        invisiPlaneBack.physicsBody = geometryNodes.getPlanePhysicsBody()
        rootNode.addChildNode(invisiPlaneBack)
        
        let invisiPlaneTop = SCNNode(geometry: invisiPlane)
        invisiPlaneTop.opacity = planeOpacity
        invisiPlaneTop.position = SCNVector3(0,planePositionScalar,0)
        invisiPlaneTop.rotation = SCNVector4(1,0,0,Float(M_PI_2))
        invisiPlaneTop.physicsBody = geometryNodes.getPlanePhysicsBody()
        rootNode.addChildNode(invisiPlaneTop)
        
        
        geometryNodes.addNodesTo(rootNode)

    }
    
    func renderer(renderer: SCNSceneRenderer, updateAtTime time: NSTimeInterval) {
//        print(time)
    }
}
