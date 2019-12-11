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
    
    var trackingNode:ARImageNode?
    
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
        
        addTrackingNode()
        setupArbiTrack()
    }
    
    
    func addTrackingNode() {
        
        // トラッキング(表示)するノードを用意
        trackingNode = ARImageNode(image: UIImage(named: "CowTracking"))
        
        // ノードの画像を正しい向きにするために回転
        trackingNode?.rotate(byDegrees: 90, axisX: 1.0, y: 0.0, z: 0.0)
        trackingNode?.rotate(byDegrees: 180.0, axisX: 0.0, y: 1.0, z: 0.0)
        trackingNode?.rotate(byDegrees: 270.0, axisX: 0.0, y: 0.0, z: 1.0)
    }
    
    func setupArbiTrack() {
        
        // ArbiTrack を初期化
        let arbiTrack = ARArbiTrackerManager.getInstance()
        arbiTrack?.initialise()
        
        // ジャイロマネージャーを初期化
        let gyroPlaceManager = ARGyroPlaceManager.getInstance()
        gyroPlaceManager?.initialise()
        
         // ターゲットとして使うノードを用意
        let targetImageNode = ARImageNode(image: UIImage(named: "CowTarget"))
        
        // デバイスのジャイロでノードが動くようにノードを　ARGyroPlaceManager に追加
        gyroPlaceManager?.world.addChild(targetImageNode);
        
        // ノードの画像を正しい向きにするために回転し、サイズを調整
        targetImageNode?.rotate(byDegrees: 90.0, axisX: 1.0, y: 0.0, z: 0.0)
        targetImageNode?.rotate(byDegrees: 180.0, axisX: 0.0, y: 1.0, z: 0.0)
        targetImageNode?.rotate(byDegrees: 270.0, axisX: 0.0, y: 0.0, z: 1.0)

        targetImageNode?.scale(byUniform: 0.3)
        
        // ARArbiTrack の targetNode に指定
        arbiTrack?.targetNode = targetImageNode
        
        // ARArbiTracker の world に trackingNode を追加
        arbiTrack?.world.addChild(trackingNode)
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
