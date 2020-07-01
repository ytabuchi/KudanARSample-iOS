//
//  ArbiViewController.swift
//  KudanARSample-iOS
//
//  Created by Yoshito Tabuchi on 2018/09/14.
//  Copyright © 2018年 Yoshito Tabuchi. All rights reserved.
//

import Foundation
import KudanAR

class ArbiViewController: ARCameraViewController {
    
    var modelNode:ARModelNode?
    
    @IBOutlet weak var changeTrackingModeButton: UIButton!
    
    @IBAction func changeTrackingModeButton_TouchUpInside(_ sender: Any) {
        
        let arbiTrack = ARArbiTrackerManager.getInstance()
        
        if let arbiTracker = arbiTrack {
            if (arbiTracker.isTracking) {
                arbiTracker.stop()
                arbiTracker.targetNode.visible = true
                
                changeTrackingModeButton.setTitle("Start Tracking", for: UIControl.State.normal)
            } else {
                arbiTracker.start()
                arbiTracker.targetNode.visible = false
                
                changeTrackingModeButton.setTitle("Stop Tracking", for: UIControl.State.normal)
            }
        }
    }
    
    override func setupContent() {
        
        addModelNode()
        setupArbiTrack()
    }
    
    
    func addModelNode() {

        // モデルのインポート
        let modelImporter = ARModelImporter(bundled: "bloodhound.armodel")
        let modelNode = modelImporter?.getNode()

        // モデルのマテリアルを設定
        let material = ARLightMaterial()
        material.colour.texture = ARTexture.init(uiImage: UIImage.init(named: "bloodhound.png"))
        material.diffuse.value = ARVector3.init(valuesX: 0.2, y: 0.2, z: 0.2)
        material.ambient.value = ARVector3.init(valuesX: 0.8, y: 0.8, z: 0.8)
        material.specular.value = ARVector3.init(valuesX: 0.3, y: 0.3, z: 0.3)
        material.shininess = 20
        material.reflection.reflectivity = 0.15
        
        // モデルの ARMeshNode にマテリアルを割り当て
        if let meshNodes = modelNode?.meshNodes {
            for case let meshNode as ARMeshNode in meshNodes {
                meshNode.material = material
            }
        }
        
        modelNode?.scale(byUniform: 5.0)
        self.modelNode = modelNode
    }
    
    func setupArbiTrack() {
        
        // ArbiTrack を初期化
        let arbiTrack = ARArbiTrackerManager.getInstance()
        arbiTrack?.initialise()
        
        // ジャイロマネージャーを初期化
        let gyroPlaceManager = ARGyroPlaceManager.getInstance()
        gyroPlaceManager?.initialise()
        
         // ターゲットとして使うノードを用意
        let targetImageNode = ARImageNode(image: UIImage(named: "target"))
        
        // デバイスのジャイロでノードが動くようにノードを　ARGyroPlaceManager に追加
        gyroPlaceManager?.world.addChild(targetImageNode);
        
        // ノードの画像を正しい向きにするために回転し、サイズを調整
        targetImageNode?.rotate(byDegrees: 90.0, axisX: 1.0, y: 0.0, z: 0.0)
        targetImageNode?.rotate(byDegrees: 180.0, axisX: 0.0, y: 1.0, z: 0.0)

        targetImageNode?.scale(byUniform: 0.1)
        
        // ARArbiTrack の targetNode に指定
        arbiTrack?.targetNode = targetImageNode
        
        // ARArbiTracker の world に modelNode を追加
        arbiTrack?.world.addChild(modelNode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
