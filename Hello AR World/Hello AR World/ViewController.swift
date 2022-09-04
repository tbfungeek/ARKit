//
//  ViewController.swift
//  Hello AR World
//
//  Created by 林晓海 on 2022/9/3.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var sphare = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.debugOptions = [
                                    ARSCNDebugOptions.showWorldOrigin,
                                    ARSCNDebugOptions.showFeaturePoints]
        
        sceneView.autoenablesDefaultLighting = true
        
        // Create a new scene
        // let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        //sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
        
        drawSphereAtOrigin()
        drawBoxAt1200Position()
        drawPyarmidAt600Low()
        drawPlaneAt900()
        drawAirPlan()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func drawSphereAtOrigin() {
        sphare = SCNNode(geometry: SCNSphere(radius: 0.05))
        sphare.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "earth")
        sphare.geometry?.firstMaterial?.specular.contents = UIColor.white;
        sphare.position = SCNVector3(0,0,0)
        sceneView.scene.rootNode.addChildNode(sphare)
        
        let rotateAction = SCNAction.rotate(by: 360.toAngleDegree()*12, around: SCNVector3(0,1,0), duration: 8)
        
        sphare.runAction(rotateAction)
    }
    
    func drawBoxAt1200Position() {
        let box = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.1 ))
        box.position = SCNVector3(0,0.2,-0.3)
        box.geometry?.firstMaterial?.diffuse.contents = UIColor.orange;
        box.geometry?.firstMaterial?.specular.contents = UIColor.white;
        sceneView.scene.rootNode.addChildNode(box)
    }
    
    func drawPyarmidAt600Low() {
        let pyarmid = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
        pyarmid.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        pyarmid.geometry?.firstMaterial?.specular.contents = UIColor.red
        pyarmid.position = SCNVector3(0,-0.2,0.3)
        pyarmid.eulerAngles = SCNVector3(45.toAngleDegree(),45.toAngleDegree(),45.toAngleDegree())
        sceneView.scene.rootNode.addChildNode(pyarmid)
    }
    
    func drawPlaneAt900() {
        let plane = SCNNode(geometry: SCNPlane(width: 0.1, height: 0.1))
        plane.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "cat")
        plane.geometry?.firstMaterial?.isDoubleSided = true
        plane.position = SCNVector3(-0.2,0,0)
        plane.eulerAngles = SCNVector3(45.toAngleDegree(),0,0)
        sceneView.scene.rootNode.addChildNode(plane)
    }
    
    func drawAirPlan() {
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let ship = scene.rootNode.childNode(withName: "ship", recursively: false)!
        ship.position = SCNVector3(0.1,0,0)
        ship.scale = SCNVector3(0.3,0.3,0.3)
        ship.eulerAngles = SCNVector3(0,180.toAngleDegree(),0)
        sphare.addChildNode(ship)
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

extension Int {
    
    func toAngleDegree() -> Double {
        Double(self) * Double.pi / 180.0
    }
}
