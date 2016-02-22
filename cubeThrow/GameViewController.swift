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
    var touchCount = 0.0
    
    var checkRest = NSTimer()
    var timer = 0.0
    
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
            

        }
    }
    
    func addGestureRecognizer(gestureRecognizer: UIGestureRecognizer) {
        
    }

    
    func handlePan(gesture:UIPanGestureRecognizer) {
        let translationY = gesture.translationInView(sceneView!).y
        let translationX = gesture.translationInView(sceneView!).x
        print("X \(translationX) by Y \(translationY)")

        
        
        if touchCount < 2 {
        
            if translationY < -100 {
                
                for node in scene.rootNode.childNodes {
                    if let physBody = node.physicsBody {
                        physBody.applyTorque(SCNVector4(1,1,1,(translationY/400-1)), impulse: true) //Perfect spin
                        physBody.applyForce(SCNVector3(translationX/17,(-translationY/130)+17,(translationY/5)-11), impulse: true) //MIN (0,17,-31) MAX (0,21,-65)
                        print("Force applied on \(physBody)")
                    }
                }
                
//                if gesture.state == UIGestureRecognizerState.Ended { //2 touches happen so fast
//                    gesture.enabled = false
//                    print("Gesture is disabled")
//                }
                
                print("touchCount \(touchCount)")
                touchCount++

                
            }
        } else if touchCount >= 2{
            checkRest = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "checkCubeRest", userInfo: nil, repeats: false)
        }
    }
    
    func handleTap(gesture:UITapGestureRecognizer) {
        
        panGesture.enabled = true
        touchCount = 0
        
        for node in scene.rootNode.childNodes {

            getUpSide(node)
            resetCubes()

        }
        
        
    }
    
    func checkCubeRest() {
        timer++
        
        var cubeRestCount = 0
        
        for node in scene.rootNode.childNodes { //todo not working
            if let physBody = node.physicsBody {
                if physBody.isResting {
                    print("CUBE IS AT REST")
                    cubeRestCount++
                }
            }
        }
        
        if cubeRestCount == 3 {
            timer = 0
            checkRest.invalidate()
            cubeRestCount = 0
        }
        print("Checking Cube Rest \(timer)")
        
//        if timer > 20 {
//            timer = 0
//            checkRest.invalidate()
//            print("Stop timer")
//        }
        
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
                node.position = SCNVector3((-0.25*count+0.17),0.15,+1.35)
                node.rotation = SCNVector4(Float(arc4random()%20),Float(arc4random()%20),Float(arc4random()%20),Float(arc4random()%20))
                
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
