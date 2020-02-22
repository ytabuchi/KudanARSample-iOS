//
//  ViewController.swift
//  KudanARSample-iOS
//
//  Created by Yoshito Tabuchi on 2020/02/22.
//  Copyright © 2020 Yoshito Tabuchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var markerImage: UIImageView!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var cameraRollButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBAction func takePhotoButton_TouchUpInside(_ sender: Any) {
        // カメラが利用可能か？
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let pickerView = UIImagePickerController()
            // 写真の選択元をカメラにする
            // 「.camera」にすればカメラを起動できる
            pickerView.sourceType = .camera
            // デリゲート
            pickerView.delegate = self
            // ビューに表示
            self.present(pickerView, animated: true)
        }
    }
    
    @IBAction func cameraRollButton_TouchUpInside(_ sender: Any) {
        // カメラロールが利用可能か？
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // 写真を選ぶビュー
            let pickerView = UIImagePickerController()
            // 写真の選択元をカメラロールにする
            // 「.camera」にすればカメラを起動できる
            pickerView.sourceType = .photoLibrary
            // デリゲート
            pickerView.delegate = self
            // ビューに表示
            self.present(pickerView, animated: true)
        }
    }
    
    @IBAction func resetButton_TouchUpInside(_ sender: Any) {
        presetImage()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toMarkerView":
            let nextVC = segue.destination as! MarkerViewController
            nextVC.marker = markerImage.image!
        default:
            print("No segue selected.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presetImage()
    }
    
    func presetImage() {
        markerImage.image = UIImage(named: "lego")!
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 写真を選んだ後に呼ばれる処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 選択した写真を取得する
        let image = info[.originalImage] as! UIImage
        // ビューに表示する
        markerImage.image = image
        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
    }
}
