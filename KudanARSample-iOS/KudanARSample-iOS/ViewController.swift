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
    
    @IBAction func clearButton_TouchUpInside(_ sender: Any) {
        clearAllNodes()
    }
    
    @IBAction func imageButton_TouchUpInside(_ sender: Any) {
        clearAllNodes()
        imageTrackable?.world.children[0].visible = true
    }
    
    @IBAction func modelButton_TouchUpInside(_ sender: Any) {
    }
    
    var imageTrackable:ARImageTrackable?
    
    override func setupContent() {
        
        setupImageTrackable()
        
        addImageNode()
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
        
        // ARImageTrackable に imageNode を追加
        imageTrackable?.world.addChild(imageNode)
        
        // マーカー画像のサイズに合わせるように、それぞれの幅から拡大率を計算
        let scaleRatio = Float(imageTrackable!.width)/Float(imageNode!.texture.width)
        
        // 拡大率を ImageNode に適用
        imageNode?.scale(byUniform: scaleRatio)
        
        imageNode?.visible = false
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

