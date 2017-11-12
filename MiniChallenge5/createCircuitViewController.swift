//
//  createCircuit.swift
//  MiniChallenge5
//
//  Created by Vinícius Cano Santos on 09/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class CreateCircuitViewController: UIViewController, ARSCNViewDelegate{
    
    //MARK: Outlets
    @IBOutlet weak var labelExplanation: UILabel!
    @IBOutlet weak var labelConstraints: NSLayoutConstraint!
    @IBOutlet weak var labelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var sceneView: ARSCNView!
    
    //MARK: Properties
    var bow:SCNNode!
    let nodeName = "bow"
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpScene()
        self.setUpBow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        //Setting up constraints
        self.labelConstraints.constant = self.view.frame.size.height * 0.149
        self.labelLeadingConstraint.constant = self.view.frame.size.width * 0.106
        self.labelTrailingConstraint.constant = self.view.frame.size.width * 0.106
        
        //Initializing ARKit session (here, the access to the camera will be necessary)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        
        let message: String = "Para adicionar um arco no circuito, apenas fique no local desejado e toque em qualquer lugar da tela."
        let alert = UIAlertController(title: "Novo Circuito", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Nenhum Circuito Disponível"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Pausing the view's session
        self.sceneView.session.pause()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Touches handler
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: sceneView)
        
        var hitTestOptions = [SCNHitTestOption: Any]()
        hitTestOptions[SCNHitTestOption.boundingBoxOnly] = true
        let hitResults: [SCNHitTestResult] = self.sceneView.hitTest(location, options: hitTestOptions)
        
        //In case of a model be hited, removes it
        if let hit = hitResults.first {
            if let node = getParent(hit.node) {
                node.removeFromParentNode()
                return
            }
        }
        
        //Else, add a new node
        let hitResultsFeaturePoints: [ARHitTestResult] = sceneView.hitTest(location, types: .featurePoint)
        if let hit = hitResultsFeaturePoints.first {
            self.bow.eulerAngles.y = self.sceneView.session.currentFrame!.camera.eulerAngles.y
            self.sceneView.session.add(anchor: ARAnchor(transform: hit.worldTransform))
        }
    }
    
    //MARK: Anchor callback functions
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if !anchor.isKind(of: ARPlaneAnchor.self) {
            DispatchQueue.main.async {
                let modelClone = self.bow.clone()
                modelClone.position = SCNVector3Zero
                //Adding bow to the world
                node.addChildNode(modelClone)
            }
        }
    }
    
    //MARK: Setup functions
    private func setUpScene(){
        self.sceneView.delegate = self
        self.sceneView.antialiasingMode = .multisampling4X
        self.sceneView.autoenablesDefaultLighting = true
        //self.sceneView.showsStatistics = true
        //self.sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
        
        //Creatint an adding a new scene
        let scene = SCNScene()
        self.sceneView.scene = scene
    }
    
    private func setUpBow(){
        let geometry = SCNTorus(ringRadius: 1, pipeRadius: 0.07)
        geometry.materials.first?.diffuse.contents = UIColor.green
        
        self.bow = SCNNode(geometry: geometry)
        self.bow.name = nodeName
        self.bow.eulerAngles.x = Float.pi/2
    }
    
    //MARK: Aux functionsAux
    private func getParent(_ nodeFound: SCNNode?) -> SCNNode? {
        if let node = nodeFound {
            if node.name == self.nodeName {
                return node
            } else if let parent = node.parent {
                return getParent(parent)
            }
        }
        return nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
