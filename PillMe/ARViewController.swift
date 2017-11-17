//
//  ViewController.swift
//  ARKitTest
//
//  Created by Chao Kang on 11/13/17.
//  Copyright © 2017 Team6. All rights reserved.
//
import UIKit
import ARKit

class ARViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addBox()
        addText()
        getCurrentDateTime()
        addTapGestureToSceneView()
    }
    
    @IBAction func arToCurButton(_ sender: Any) {
        //print("yolo")
        performSegue(withIdentifier: "arToCurSeg", sender: self)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    func addBox(x: Float = 0, y: Float = 0, z: Float = -0.8) {
        let box = SCNCapsule(capRadius: 0.1, height: 0.5)
        let boxNode = SCNNode()
        boxNode.geometry = box
        box.firstMaterial?.diffuse.contents  = UIColor(red: 120.0 / 255.0, green: 42.0 / 255.0, blue: 42.0 / 255.0, alpha: 0.99)
        boxNode.position = SCNVector3(x, y, z)
        
        sceneView.scene.rootNode.addChildNode(boxNode)
        
        let moveUp = SCNAction.moveBy(x: 0, y: 0.5, z: 0, duration: 1)
        moveUp.timingMode = .easeInEaseOut;
        let moveDown = SCNAction.moveBy(x: 0, y: -0.5, z: 0, duration: 1)
        moveDown.timingMode = .easeInEaseOut;
        let moveSequence = SCNAction.sequence([moveUp,moveDown])
        let moveLoop = SCNAction.repeatForever(moveSequence)
        boxNode.runAction(moveLoop)

    }
    func addText()
    {
        let text = SCNText(string: "Pill Me!", extrusionDepth: 0.2)
        text.font = UIFont(name: "Copperplate", size: 1)
        let textNode = SCNNode()
        textNode.geometry = text
        textNode.scale = SCNVector3Make(0.50, 0.325, 0.50)
        textNode.position = SCNVector3(-1, -1, -2)
        sceneView.scene.rootNode.addChildNode(textNode)
    }
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ARViewController.didTap(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        guard let node = hitTestResults.first?.node else {
            let hitTestResultsWithFeaturePoints = sceneView.hitTest(tapLocation, types: .featurePoint)
            if let hitTestResultWithFeaturePoints = hitTestResultsWithFeaturePoints.first {
                let translation = hitTestResultWithFeaturePoints.worldTransform.translation
                addBox(x: translation.x, y: translation.y, z: translation.z)
            }
            return
        }
        node.removeFromParentNode()
    }
    func getCurrentDateTime()
    {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        print (hour)
        print (minutes)
    }
}
extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
    
    
    
    
    
}

