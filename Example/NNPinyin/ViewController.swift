//
//  ViewController.swift
//  NNPinyin
//
//  Created by YiHuaXie on 05/08/2020.
//  Copyright (c) 2020 YiHuaXie. All rights reserved.
//

import UIKit
import NNPinyin

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        debugPrint("绿色".toPinyin())
        var outputFormat = NNPinyinOutputFormat(vCharType: .uUnicode)
        debugPrint("绿色".toPinyin(withFormat: outputFormat))
        outputFormat = NNPinyinOutputFormat(toneType: .toneNumber, vCharType: .uAndColon, letterType: .uppercased)
        debugPrint("绿色".toPinyin(withFormat: outputFormat))
        debugPrint("你在幹什麼".toPinyinAcronym())
        debugPrint("Hello".toPinyin())
        debugPrint("测试dasdasd".hasChineseCharacter)
    }
}


