//
//  ViewController.swift
//  KudanARSample-iOS
//
//  Created by Yoshito Tabuchi on 2018/07/24.
//  Copyright © 2018年 Yoshito Tabuchi. All rights reserved.
//

import UIKit
import KudanAR

class ViewController: ARCameraViewController {

    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var modelButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    
    @IBAction func clearButton_TouchUpInside(_ sender: Any) {
        clearAllNodes()
    }
    
    @IBAction func imageButton_TouchUpInside(_ sender: Any) {
        clearAllNodes()
        imageTrackable?.world.children[0].visible = true
    }
    
    @IBAction func modelButton_TouchUpInside(_ sender: Any) {
        clearAllNodes()
        imageTrackable?.world.children[1].visible = true
    }
    
    @IBAction func videoButton_TouchUpInside(_ sender: Any) {
        clearAllNodes()
        // videoNode のビデオが終了したら消えてしまうのをリセットさせてから再生して回避しています。
        videoNode?.reset()
        videoNode?.play()
        imageTrackable?.world.children[2].visible = true
    }
    
    
    var imageTrackable:ARImageTrackable?
    var videoNode:ARVideoNode?
    
    override func setupContent() {
        
        setupImageTrackable()
        
        addImageNode()
        addModelNode()
        addVideoNode()
    }
    
    func setupImageTrackable() {
        // ARImageTrackable オブジェクトのインスタンス化と初期化
        imageTrackable = ARImageTrackable.init(image: UIImage(named: "lego.jpg"), name: "lego")
        
        // image tracker manager のインスタンスを取得して初期化
        let imageTrackerManager = ARImageTrackerManager.getInstance()
        imageTrackerManager?.initialise()
        
        // ARImageTrackable を　image tracker manager に追加
        imageTrackerManager?.addTrackable(imageTrackable)
    }
    
    func addImageNode() {
        // ImageNode を表示させたい画像で初期化
        // PNG の場合は拡張子は不要です。
        let imageNode = ARImageNode(image: UIImage(named: "cow"))
        
        // マーカー画像のサイズに合わせるように、それぞれの幅から拡大率を計算
        let scaleRatio = Float(imageTrackable!.width)/Float(imageNode!.texture.width)
        // 拡大率を ImageNode に適用
        imageNode?.scale(byUniform: scaleRatio)

        // ARImageTrackable に imageNode を追加
        imageTrackable?.world.addChild(imageNode)

        imageNode?.visible = false
    }
    
    func addModelNode() {
        // モデルのインポート
        let modelImporter = ARModelImporter(bundled: "ben.armodel")
        let modelNode = modelImporter?.getNode()
        
        // モデルの ARMeshNode にアンビエントライトを適用
        if let meshNodes = modelNode?.meshNodes {
            for case let meshNode as ARMeshNode in meshNodes {
                let material = meshNode.material as? ARLightMaterial
                material?.ambient.value = ARVector3(valuesX: 0.8, y: 0.8, z: 0.8)
            }
        }
 
        // 向きと拡大率を指定
        modelNode?.rotate(byDegrees: 90, axisX: 1, y: 0, z: 0)
        modelNode?.scale(byUniform: 0.25)
        
        // ARImageTrackable に modelNode を追加
        imageTrackable?.world.addChild(modelNode)
        
        modelNode?.visible = false
    }
    
    func addVideoNode() {
        // videoNode を mp4 ファイルで初期化
        videoNode = ARVideoNode.init(bundledFile: "waves.mp4")
        
        // 拡大率を指定
        let scaleRatio = Float(imageTrackable!.width) / Float(videoNode!.videoTexture.width)
        videoNode?.scale(byUniform: scaleRatio)
        
        // ARImageTrackable に videoNode を追加
        imageTrackable?.world.addChild(videoNode)
        
        videoNode?.visible = false
    }
    
    func clearAllNodes() {
        let nodes = imageTrackable?.world.children
        nodes?.forEach({ (node) in
            node.visible = false
        })
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

