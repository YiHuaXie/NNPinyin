//
//  String+NNPinyin.swift
//  NNPinyin
//
//  Created by NeroXie on 2020/5/8.
//  Copyright © 2020 NeroXie. All rights reserved.
//

import Foundation

public extension String {
    
    /// 全拼
    func toPinyin(withFormat outputFormat: NNPinyinOutputFormat = .default, separator: String = " ") -> String {
        var strings = [String]()
        for unicodeScalar in unicodeScalars {
            let pinyinList = NNPinyin.pinyinList(with: unicodeScalar.value, outputFormat: outputFormat)

            if pinyinList.count > 0 {
                strings.append(pinyinList.first! + separator)
            } else {
                strings.append(String(unicodeScalar))
            }
        }

        var pinyin = strings.joined(separator: "")
        if !pinyin.isEmpty && String(pinyin.suffix(from: pinyin.index(pinyin.endIndex, offsetBy: -1))) == separator {
            pinyin.remove(at: pinyin.index(pinyin.endIndex, offsetBy: -1))
        }

        return pinyin
    }

    func toPinyin(withFormat outputFormat: NNPinyinOutputFormat = .default, separator: String = " ", completion: @escaping (String) -> Void) {
        DispatchQueue.global(qos: .default).async {
            let pinyin = self.toPinyin(withFormat: outputFormat, separator: separator)
            DispatchQueue.main.async { completion(pinyin) }
        }
    }

    /// 首字母缩写
    func toPinyinAcronym(withFormat outputFormat: NNPinyinOutputFormat = .default, separator: String = "") -> String {
        var strings = [String]()
        for unicodeScalar in unicodeScalars {
            let pinyinList = NNPinyin.pinyinList(with: unicodeScalar.value, outputFormat: outputFormat)
            if pinyinList.count > 0 {
                let acronym = pinyinList.first!.first!
                strings.append(String(acronym) + separator)
            } else {
                strings.append(String(unicodeScalar))
            }
        }
        
        var pinyinAcronym = strings.joined(separator: "")
        if !pinyinAcronym.isEmpty && String(pinyinAcronym.suffix(from: pinyinAcronym.index(pinyinAcronym.endIndex, offsetBy: -1))) == separator {
            pinyinAcronym.remove(at: pinyinAcronym.index(pinyinAcronym.endIndex, offsetBy: -1))
        }
        
        return pinyinAcronym
    }

    func toPinyinAcronym(withFormat outputFormat: NNPinyinOutputFormat = .default, separator: String = "", completion: @escaping (String) -> Void) {
        DispatchQueue.global(qos: .default).async {
            let pinyinAcronym = self.toPinyinAcronym(withFormat: outputFormat, separator: separator)
            DispatchQueue.main.async { completion(pinyinAcronym) }
        }
    }

    /// 是否有中文字符
    var hasChineseCharacter: Bool {
        for unicodeScalar in unicodeScalars {
            if NNPinyin.isHanzi(ofCharCode: unicodeScalar.value) { return true }
        }
        
        return false
    }
}
