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
    var panGesture = UIPanGestureRecognizer.self()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView = self.view as? SCNView
        
        if let view = sceneView {
            
            view.scene = scene
            view.delegate = scene
            view.playing = true
            view.backgroundColor = UIColor.blackColor()
            view.antialiasingMode = SCNAntialiasingMode.Multisampling4X
            
            
            panGesture = UIPanGestureRecognizer(target: self, action: "handlePan:")
            view.addGestureRecognizer(panGesture)

            let tapGesture = UITapGestureRecognizer(target: self, action: "handleTap:")
            
            
            view.addGestureRecognizer(tapGesture)
            
//            view.touchesEnded(panGesture, withEvent: nil)
        }
        
    }
    
    func addGestureRecognizer(gestureRecognizer: UIGestureRecognizer) {
        
    }

    
    func handlePan(gesture:UIPanGestureRecognizer) {
        let translationY = gesture.translationInView(sceneView!).y
        let translationX = gesture.translationInView(sceneView!).x
        
        print("X \(translationX) by Y \(translationY)")
        

        
        
        for node in scene.rootNode.childNodes {
            
            if let physBody = node.physicsBody {

                if translationY < -100 {
                    //                physBody.applyTorque(SCNVector4(x: -2.79, y: 0.336, z: -2.79, w: 0.336), impulse: true)
                    //                physBody.applyForce(SCNVector3(x: -1.395, y: 3.45333, z: 3.45333), impulse: true)
                    
                    physBody.applyTorque(SCNVector4( -(translationY/400), (translationY/400), (-translationY/400), -(translationY/400)), impulse: true)
                    physBody.velocity = SCNVector3(translationX/100,(translationY/400+3.5),-(translationY/400+3.5))
                    
                    if gesture.state == UIGestureRecognizerState.Ended {
                        gesture.enabled = false
                        print("Ended")
                    }

                    //TODO: need to limit the amount of time while throwing (could be too long)
                    //TODO: the minimum throw is too low and the max is too strong
                }
                

            }
        
        }

    }
    
    func handleTap(gesture:UITapGestureRecognizer) {
        
        panGesture.enabled = true

        for node in scene.rootNode.childNodes {

            getUpSide(node)
            resetCubes()

//            if let physBody = node.physicsBody {
//                print(node.orientation)
//                print(node.name)
//            }

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
        
        var count = 0.0
        
        for node in scene.rootNode.childNodes {
            
            if node.name == "cube" {
                node.physicsBody?.velocity = SCNVector3(0,0,0)
                node.physicsBody?.angularVelocity = SCNVector4(0,0,0,0)
                node.position = SCNVector3(-0.15*count,0.15,+1.35)
                count++
            }

            
        }
        
        count = 0.0
        
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
