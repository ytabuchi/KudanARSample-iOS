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

    override func setupContent() {
        // Setup code goes here
        // ARImageTrackable オブジェクトのインスタンス化と初期化
        let imageTrackable = ARImageTrackable.init(image: UIImage(named: "Lego.jpg"), name: "Lego")
        
        // image tracker manager のインスタンスを取得して初期化
        let imageTrackerManager = ARImageTrackerManager.getInstance()
        imageTrackerManager?.initialise()
        
        // ARImageTrackable を　image tracker manager に追加
        imageTrackerManager?.addTrackable(imageTrackable)
        
        // ImageNode を表示させたい画像で初期化
        // PNG の場合は拡張子は不要です。
        let imageNode = ARImageNode(image: UIImage(named: "Cow"))
        
        // ARImageTrackable に imageNode を追加
        imageTrackable?.world.addChild(imageNode)

        // マーカー画像のサイズに合わせるように、それぞれの幅から拡大率を計算
        let scaleRatio = Float(imageTrackable!.width)/Float(imageNode!.texture.width)
        
        // 拡大率を ImageNode に適用
        imageNode?.scale(byUniform: scaleRatio)
        
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

