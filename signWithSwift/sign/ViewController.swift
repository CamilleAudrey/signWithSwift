//
//  ViewController.swift
//  sign
//
//  Created by imac on 17/7/18.
//  Copyright © 2017年 Guowu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var preSignImageView: UIImageView!
    var signView: SignView!
    
    var preShowBtn: UIButton!
    var saveSignBtn: UIButton!
    var clearSignBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //签名区域的位置尺寸
        var signViewFrame = self.view.bounds
        signViewFrame.size.height = 200
        
        //添加签名区域
        signView = SignView.init(frame: signViewFrame)
        signView.backgroundColor = UIColor.cyan
        self.view.addSubview(signView)
        
        preShowBtn = UIButton.init(frame: CGRect.init(x: 10, y: 210, width: 50, height: 40))
        saveSignBtn = UIButton.init(frame: CGRect.init(x: 70, y: 210, width: 50, height: 40))
        clearSignBtn = UIButton.init(frame: CGRect.init(x: 130, y: 210, width: 50, height: 40))
        
        preShowBtn.setTitle("预览", for: .normal)
        saveSignBtn.setTitle("保存", for: .normal)
        clearSignBtn.setTitle("清除", for: .normal)
        
        preShowBtn.setTitleColor(UIColor.blue, for: .normal)
        saveSignBtn.setTitleColor(UIColor.blue, for: .normal)
        clearSignBtn.setTitleColor(UIColor.blue, for: .normal)
        
        preShowBtn.addTarget(self, action: #selector(preShowSign), for: .touchUpInside)
        saveSignBtn.addTarget(self, action: #selector(saveSign), for: .touchUpInside)
        clearSignBtn.addTarget(self, action: #selector(clearSign), for: .touchUpInside)
        self.view.addSubview(preShowBtn)
        self.view.addSubview(saveSignBtn)
        self.view.addSubview(clearSignBtn)
        
        preSignImageView = UIImageView.init(frame: CGRect.init(x: 10, y: 260, width: UIScreen.main.bounds.size.width-20, height:150))
        preSignImageView.backgroundColor = UIColor.yellow
        self.view.addSubview(preSignImageView)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func preShowSign() {
       print("预览")
        
        let signatureImage = self.signView.getSignature()
        preSignImageView.image = signatureImage
        
    }
    func saveSign() {
        print("保存")
        let signatureImage = self.signView.getSignature()
        UIImageWriteToSavedPhotosAlbum(signatureImage, nil, nil, nil)
        self.signView.clearSignature()
        
    }
    func clearSign() {
        print("清除")
        self.signView.clearSignature()
        self.preSignImageView.image = nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

