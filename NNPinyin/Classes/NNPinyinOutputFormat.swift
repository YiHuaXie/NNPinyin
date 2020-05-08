//
//  NNPinyinOutputFormat.swift
//  NNPinyin
//
//  Created by NeroXie on 2020/5/8.
//  Copyright © 2020 NeroXie. All rights reserved.
//

import Foundation

/// 拼音输出格式
public struct NNPinyinOutputFormat {
    
    public var toneType: ToneType
    
    public var vCharType: VCharType
    
    public var letterType: LetterType

    public static var `default`: NNPinyinOutputFormat {
        NNPinyinOutputFormat()
    }

    public init(
        toneType: ToneType = .none,
        vCharType: VCharType = .vCharacter,
        letterType: LetterType = .lowercased
    ) {
        self.toneType = toneType
        self.vCharType = vCharType
        self.letterType = letterType
    }
}

extension NNPinyinOutputFormat {
    
    /// 音调
    public enum ToneType {
        
        case none // 不带音调
        
        case toneNumber // 带音调
    }

    /// v的样式
    public enum VCharType {
        
        case vCharacter // u: -> v
        
        case uUnicode // u: -> ü
        
        case uAndColon // u: -> u:
    }

    /// 字母样式
    public enum LetterType {
        
        case lowercased // 小写
        
        case uppercased // 大写
        
        case capitalized // 首字母大写
    }
}

