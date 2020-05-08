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
        
        let string = "绿"
        //        let pinyin = string.toPinyin()
        //        debugPrint(pinyin)
        
        let outputFormat1 = NNPinyinOutputFormat(toneType: .none, vCharType: .uAndColon, letterType: .capitalized)
        let outputFormat2 = NNPinyinOutputFormat(toneType: .none, vCharType: .uAndColon, letterType: .lowercased)
        let outputFormat3 = NNPinyinOutputFormat(toneType: .none, vCharType: .uAndColon, letterType: .uppercased)
        let outputFormat4 = NNPinyinOutputFormat(toneType: .none, vCharType: .uUnicode, letterType: .capitalized)
        let outputFormat5 = NNPinyinOutputFormat(toneType: .none, vCharType: .uUnicode, letterType: .lowercased)
        let outputFormat6 = NNPinyinOutputFormat(toneType: .none, vCharType: .uUnicode, letterType: .uppercased)
        let outputFormat7 = NNPinyinOutputFormat(toneType: .none, vCharType: .vCharacter, letterType: .capitalized)
        let outputFormat8 = NNPinyinOutputFormat(toneType: .none, vCharType: .vCharacter, letterType: .lowercased)
        let outputFormat9 = NNPinyinOutputFormat(toneType: .none, vCharType: .vCharacter, letterType: .uppercased)
        let outputFormat10 = NNPinyinOutputFormat(toneType: .toneNumber, vCharType: .uAndColon, letterType: .capitalized)
        let outputFormat11 = NNPinyinOutputFormat(toneType: .toneNumber, vCharType: .uAndColon, letterType: .lowercased)
        let outputFormat12 = NNPinyinOutputFormat(toneType: .toneNumber, vCharType: .uAndColon, letterType: .uppercased)
        let outputFormat13 = NNPinyinOutputFormat(toneType: .toneNumber, vCharType: .uUnicode, letterType: .capitalized)
        let outputFormat14 = NNPinyinOutputFormat(toneType: .toneNumber, vCharType: .uUnicode, letterType: .lowercased)
        let outputFormat15 = NNPinyinOutputFormat(toneType: .toneNumber, vCharType: .uUnicode, letterType: .uppercased)
        let outputFormat16 = NNPinyinOutputFormat(toneType: .toneNumber, vCharType: .vCharacter, letterType: .capitalized)
        let outputFormat17 = NNPinyinOutputFormat(toneType: .toneNumber, vCharType: .vCharacter, letterType: .lowercased)
        let outputFormat18 = NNPinyinOutputFormat(toneType: .toneNumber, vCharType: .vCharacter, letterType: .uppercased)
        
        let outputFormats = [
            outputFormat1,
            //            outputFormat2,
            outputFormat3,
            outputFormat4,
            //            outputFormat5,
            outputFormat6,
            outputFormat7,
            //            outputFormat8,
            outputFormat9,
            //            outputFormat10,
            //            outputFormat11,
            //            outputFormat12,
            //            outputFormat13,
            //            outputFormat14,
            //            outputFormat15,
            //            outputFormat16,
            //            outputFormat17,
            //            outputFormat18
        ]
        
        for element in outputFormats {
            debugPrint(string.toPinyin(withFormat: element, separator: " "))
        }
        
        NNPinyinClearUnicodeToPinyinMap()
        
        debugPrint("你好".toPinyin())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

