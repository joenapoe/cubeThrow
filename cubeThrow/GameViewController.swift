//
//  GameViewController.swift
//  cubeThrow
//
//  Created by Joseph Pelina on 2/16/16.
//  Copyright (c) 2016 redgarage. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    
    var sceneView: SCNView?
    var scene = GameScene(create: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView = self.view as? SCNView
        
        if let view = sceneView {
            
            view.scene = scene
            view.delegate = scene
            view.playing = true
            view.backgroundColor = UIColor.blackColor()
            view.antialiasingMode = SCNAntialiasingMode.Multisampling4X
            
            let panGesture = UIPanGestureRecognizer(target: self, action: "handlePan:")
            view.addGestureRecognizer(panGesture)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: "handleTap:")
            view.addGestureRecognizer(tapGesture)
            
//            view.touchesEnded(panGesture, withEvent: "handlePan:")
        }
        
    }
    
    func handlePan(gesture:UIPanGestureRecognizer) {
        let translationY = gesture.translationInView(sceneView!).y
        let translationX = gesture.translationInView(sceneView!).x
        
        print("X \(translationX) by Y \(translationY)")


        
        for node in scene.rootNode.childNodes {
            
            if let physBody = node.physicsBody {
//                physBody.applyForce(SCNVector3(translationX/25,-translationY/50,translationY/25), impulse: true)
//                physBody.angularVelocity = SCNVector4(translationX/10,translationX/10,translationX/10,translationX/10)
                physBody.applyTorque(SCNVector4(translationX/50,(translationY/1000+0.2),translationX/50,(translationY/1000+0.2)), impulse: true)
                physBody.velocity = SCNVector3(translationX/100,(translationY/300+3),(translationY/300+3))
                physBody.affectedByGravity = true
            }
        }

    }
    
    func handleTap(gesture:UITapGestureRecognizer) {
        
        for node in scene.rootNode.childNodes {
            
            if let physBody = node.physicsBody {
                
//                print(node.orientation)
  
                print(node.name)
                getUpSide(node)
                
                
                resetCubes()
                
            }
        }
        
        
        
    
    }
    
    func getUpSide(node: SCNNode) {
        
            var rotation = node.rotation; //SCNVector4
            var invRotation = rotation; invRotation.w = -invRotation.w; //SCNVector4
            
            var up = SCNVector3Make(0,1,0);
            
            //rotate up by invRotation
            var transform = SCNMatrix4MakeRotation(invRotation.w, invRotation.x, invRotation.y, invRotation.z); //SCNMatrix4
            var glkTransform = SCNMatrix4ToGLKMatrix4(transform); //GLKMatrix4
            var glkUp = SCNVector3ToGLKVector3(up); //GLKVector3
            var rotatedUp = GLKMatrix4MultiplyVector3(glkTransform, glkUp); //GLKVector3
            
            //build box normals (arbitrary order here)
            var boxNormals =    [ [[0,0,1]],
                                  [[1,0,0]],
                                  [[0,0,-1]],
                                  [[-1,0,0]],
                                  [[0,1,0]],
                                  [[0,-1,0]] ] //GLKVector3
            
        var bestIndex: Int = 0;
        var maxDot: Float = -1;
//        
//            for  i in 0...5 {
//                var dot: Float = GLKVector3DotProduct(boxNormals[i], rotatedUp);
//                if(dot > maxDot){
//                    maxDot = dot;
//                    bestIndex = i;
//                }
//            }
//            
//            return bestIndex;
        }
    
    
    func resetCubes() {
        
        for node in scene.rootNode.childNodes {
            
            if node.name == "cube" {
                print(node)
                node.position = SCNVector3(0,0.15,-1.25)
            }
            
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
}
