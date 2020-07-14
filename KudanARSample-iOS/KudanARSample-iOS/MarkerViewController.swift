//
//  MarkerViewController.swift
//  KudanARSample-iOS
//
//  Created by Yoshito Tabuchi on 2018/07/24.
//  Copyright © 2018年 Yoshito Tabuchi. All rights reserved.
//

import UIKit
import KudanAR

class MarkerViewController: ARCameraViewController {

    var marker :UIImage?
    var imageTrackable: ARImageTrackable?
    var secondImageTrackable: ARImageTrackable?
    // 表示される Node
    var imageNode: ARImageNode?
    var modelNode:ARModelNode?
    var videoNode: ARVideoNode?
    var alphaVideoNode: ARAlphaVideoNode?
    // 各 Node の scale
    var imageNodeScaleRatio: Float = 0
    // 表示されている Node 名
    enum node {
        case Image, Model, Video, AlphaVideo
    }
    var shownNode: node?
    
    var lastScale:CGFloat?
    var lastPanX:CGFloat?
    
    // ボタンに被らないように overlayView を作成し、そこに Gesture をアタッチします。
//    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var modelButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var alphaVideoButton: UIButton!
    
    @IBAction func clearButton_TouchUpInside(_ sender: Any) {
        clearAllNodes()
    }
    
    @IBAction func imageButton_TouchUpInside(_ sender: Any) {
        clearAllNodes()
        shownNode = node.Image
        imageTrackable?.world.children[0].visible = true
        secondImageTrackable?.world.children[0].visible = true
    }
    
    @IBAction func modelButton_TouchUpInside(_ sender: Any) {
        clearAllNodes()
        shownNode = node.Model
        imageTrackable?.world.children[1].visible = true
    }
    
    @IBAction func videoButton_TouchUpInside(_ sender: Any) {
        clearAllNodes()
        videoNode?.reset()
        videoNode?.play()
        imageTrackable?.world.children[2].visible = true
    }
    
    @IBAction func alphaVideoButon_TouchUpInside(_ sender: Any) {
        clearAllNodes()
        alphaVideoNode?.videoTexture.reset()
        alphaVideoNode?.videoTexture.play()
        imageTrackable?.world.children[3].visible = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setupContent() {
        setupImageTrackable()
        
        addImageNode()
        addModelNode()
        addVideoNode()
        addAlphaVideoNode()
        
        addSecondImageNode()
        
        // ジェスチャーの生成と cameraView へのアタッチ
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchNode(sender:)))
        self.cameraView.addGestureRecognizer(pinchGestureRecognizer)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(rotateNode(sender:)))
        self.cameraView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func pinchNode(sender: UIPinchGestureRecognizer) {
        // 各 Node により処理が違う可能性を考慮。
        switch shownNode {
        case .Image:
            pinchImage(imageScale: sender.scale)
        case .Model:
            pinchModel(sender: sender)
        default:
            NSLog("Pinched: \(sender.scale)")
        }
    }
    
    func pinchImage(imageScale: CGFloat) {
        let minScale = imageNodeScaleRatio / 4
        let maxScale = imageNodeScaleRatio * 8
        
        if (imageNode!.scale.x >= minScale &&
            imageNode!.scale.x <= maxScale) {
            imageNode?.scale(byUniform: Float(imageScale))
            
            // 範囲をオーバーしたらスケールを止める
            if (imageNode!.scale.x > maxScale) {
                imageNode?.scale = ARVector3.init(valuesX: maxScale, y: maxScale, z: maxScale)
            }
            if (imageNode!.scale.x < minScale) {
                imageNode?.scale = ARVector3.init(valuesX: minScale, y: minScale, z: minScale)
            }
        }
    }
    
    func pinchModel(sender: UIPinchGestureRecognizer) {
        var scaleFactor = sender.scale
        
        if (sender.state == UIGestureRecognizer.State.began) {
            lastScale = 1
        }
        
        if let scale = lastScale {
            scaleFactor = 1 - (scale - scaleFactor)
            lastScale = sender.scale
            
            self.modelNode?.scale(byUniform: Float(scaleFactor))
        }
    }

    @objc func rotateNode(sender: UIPanGestureRecognizer) {
        switch shownNode {
//        case .Image:
//            rotateImage(imageRotation: sender.rotation)
        case .Model:
            rotateModel(sender: sender)
        default:
            NSLog("Panned: \(sender.translation(in: self.view))")
        }
    }
    
    func rotateImage(imageRotation: CGFloat) {
        imageNode?.rotate(byRadians: Float(-imageRotation / 5), axisX: 0, y: 0, z: 1)
    }
    func rotateModel(sender: UIPanGestureRecognizer) {
        let x = sender.translation(in: self.cameraView).x
        
        if (sender.state == UIGestureRecognizer.State.began) {
            lastPanX = x
        }
        
        if let panX = lastPanX {
            let diff = x - panX
            let degree = diff * 0.25
            
            self.modelNode?.rotate(byDegrees: Float(degree), axisX: 0, y: 1, z: 0
            
            )
        }

        NSLog("Panned: \(sender.translation(in: self.view))")
    }
    
    func setupImageTrackable() {
        // ARImageTrackable オブジェクトのインスタンス化と初期化
//        imageTrackable = ARImageTrackable.init(image: UIImage(named: "lego.jpg"), name: "legoMarker")
        imageTrackable = ARImageTrackable.init(image: marker!, name: "marker")
        secondImageTrackable = ARImageTrackable.init(image: UIImage(named: "KudanPanel.jpg"), name: "panelMarker")
        
        // image tracker manager のインスタンスを取得して初期化
        let imageTrackerManager = ARImageTrackerManager.getInstance()
        imageTrackerManager?.initialise()
        
        // ARImageTrackable を　image tracker manager に追加
        imageTrackerManager?.addTrackable(imageTrackable)
        imageTrackerManager?.addTrackable(secondImageTrackable)
    }
    
    
    func addImageNode() {
        // ImageNode を表示させたい画像で初期化
        // PNG の場合は拡張子は不要です。
        imageNode = ARImageNode(image: UIImage(named: "cow"))
        
        // マーカー画像のサイズに合わせるように、それぞれの幅から拡大率を計算
        imageNodeScaleRatio = Float(imageTrackable!.width)/Float(imageNode!.texture.width)
        NSLog("ScaleRatio: \(imageNodeScaleRatio)")
        // 拡大率を ImageNode に適用
        imageNode?.scale(byUniform: imageNodeScaleRatio)

        // ARImageTrackable に imageNode を追加
        imageTrackable?.world.addChild(imageNode)
        
        imageNode?.visible = false
    }
    
    func addModelNode() {
        /* BigBen のモデル
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
        */
        
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
        
        modelNode?.scale(byUniform: 15.0)
        modelNode?.rotate(byDegrees: 90, axisX: 1.0, y: 0.0, z: 0.0)
        self.modelNode = modelNode
        // ARImageTrackable に videoNode を追加
        imageTrackable?.world.addChild(self.modelNode)
        
        self.modelNode?.visible = false
    }
    
    func addVideoNode() {
        // videoNode を mp4 ファイルで初期化
        videoNode = ARVideoNode.init(bundledFile: "water-and-bubbles.mp4")
        
        // 拡大率を指定
        let scaleRatio = Float(imageTrackable!.width) / Float(videoNode!.videoTexture.width)
        videoNode?.scale(byUniform: scaleRatio)
        
        // くり返しを指定
        videoNode?.videoTexture.resetThreshold = 2
        videoNode?.reset()
        videoNode?.play()
        
        // ARImageTrackable に videoNode を追加
        imageTrackable?.world.addChild(videoNode)
        
        videoNode?.visible = false
    }
    
    func addAlphaVideoNode() {
        // AlphaVideoNode を mp4 ファイルで初期化
        alphaVideoNode = ARAlphaVideoNode.init(bundledFile: "kaboom_alpha_video.mp4")
        
        // 拡大率を指定
        let scaleRatio = Float(imageTrackable!.width) / Float(alphaVideoNode!.videoTexture.width) * 5
        alphaVideoNode?.scale(byUniform: scaleRatio)

        // くり返しを指定
        alphaVideoNode?.videoTexture.resetThreshold = 2
        alphaVideoNode?.videoTexture.reset()
        alphaVideoNode?.videoTexture.play()
        
        // ARImageTrackable に videoNode を追加
        imageTrackable?.world.addChild(alphaVideoNode)
        
        alphaVideoNode?.visible = false
    }
    
    func addSecondImageNode(){
        let imageNode = ARImageNode(image: UIImage(named: "cow"))
        let scaleRatio = Float(secondImageTrackable!.width)/Float(imageNode!.texture.width)
        imageNode?.scale(byUniform: scaleRatio)
        secondImageTrackable?.world.addChild(imageNode)
        
        imageNode?.visible = false
    }
    
    func clearAllNodes() {
        shownNode = nil
        resetAllNodes()
        let nodes = imageTrackable?.world.children
        nodes?.forEach({ (node) in
            node.visible = false
        })
        
        let secondNodes = secondImageTrackable?.world.children
        secondNodes?.forEach({ (secondNode) in
            secondNode.visible = false
        })
    }
    
    func resetAllNodes() {
        // imageNode を 初期のスケールレシオでリセット
        imageNode?.scale = ARVector3.init(valuesX: imageNodeScaleRatio, y: imageNodeScaleRatio, z: imageNodeScaleRatio)
        // TODO: ImageNode の初期の回転に戻す操作
        
    }
}

