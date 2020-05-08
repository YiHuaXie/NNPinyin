//
//  NNPinyin.swift
//  NNPinyin
//
//  Created by NeroXie on 2020/5/8.
//  Copyright © 2020 NeroXie. All rights reserved.
//

import Foundation

// unicode的汉字块
private struct HanziUnicode {
    
    static let start: UInt32 = 0x4E00
    
    static let end: UInt32 = 0x9FFF
}

// 释放unicodeToPinyinMap，大概有800K
public func NNPinyinClearUnicodeToPinyinMap() {
    NNPinyin.shared._unicodeToPinyinMap = [:]
}

class NNPinyin {
    
    typealias UnicodeToPinyinMap = [String: String]
    
    class BundleOfSelf { }
    
    static var shared = NNPinyin()
    
    fileprivate(set) var _unicodeToPinyinMap: UnicodeToPinyinMap = [:]
    
    var unicodeToPinyinMap: UnicodeToPinyinMap {
        if _unicodeToPinyinMap.isEmpty {
            _unicodeToPinyinMap = initializeUnicodeToPinyinMap()
        }
        
        return _unicodeToPinyinMap
    }

    init() {}

    static func pinyinList(with charCode: UInt32, outputFormat: NNPinyinOutputFormat = .default) -> [String] {
        func isValidPinyin(_ pinyin: String) -> Bool {
            pinyin != "(none0)" && pinyin.hasPrefix("(") && pinyin.hasSuffix(")")
        }
        
        let codePointHex = String(format: "%x", charCode).uppercased()
        
        guard let pinyin = shared.unicodeToPinyinMap[codePointHex], isValidPinyin(pinyin) else {
            return []
        }
        
        let leftBracketRange = pinyin.range(of: "(")!
        let rightBracketRange = pinyin.range(of: ")")!
        let processedPinyin = String(pinyin[leftBracketRange.upperBound..<rightBracketRange.lowerBound])
        let pinyinList = processedPinyin.components(separatedBy: ",")
        
        return pinyinList.map { NNPinyinFormatter.format($0, withOutputFormat: outputFormat) }
    }

    // 判断是否是汉字
    static func isHanzi(ofCharCode charCode: UInt32) -> Bool {
        charCode >= HanziUnicode.start && charCode <= HanziUnicode.end
    }
}

// MARK: - Resource

extension NNPinyin {
    
    /// 获取资源的bundle
    private var resourceBundle: Bundle {
        let bundle = Bundle(for: BundleOfSelf.self)
        guard let bundleURL = bundle.url(forResource: "NNPinyin", withExtension: "bundle") else {
            return bundle
        }

        return Bundle(url: bundleURL) ?? bundle
    }
    
    /// 初始化资源
    func initializeUnicodeToPinyinMap() -> UnicodeToPinyinMap {
        if let cachedPinyinMap = type(of: self).cachedUnicodeToPinyinMap() {
            return cachedPinyinMap
        }
        
        guard let resourcePath = resourceBundle.path(forResource: "unicode_to_hanyu_pinyin", ofType: "txt") else {
            return [:]
        }
        
        do {
            let unicodeToPinyinText = try String(contentsOf: URL(fileURLWithPath: resourcePath))
            let textComponents = unicodeToPinyinText.components(separatedBy: "\r\n")

            var pinyinMap = [String: String]()

            textComponents.forEach { pinyin in
                let components = pinyin.components(separatedBy: .whitespaces)
                if components.count > 1 {
                    pinyinMap.updateValue(components[1], forKey: components[0])
                }
            }
            
            type(of: self).cache(pinyinMap)
            return pinyinMap
        } catch _ {
            return [:]
        }
    }
}

// MARK: - Cache

private extension String {
    
    static var unicodeToPinyin: String { "NNPinyin.UnicodeToPinyin" }
}

extension NNPinyin {
    
    /// 缓存路径
    fileprivate static var pinyinCachePath: String? {
        guard let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return nil
        }

        let cachePath = NSString(string: documentsPath).appendingPathComponent("PinyinCache")
        if !FileManager.default.fileExists(atPath: cachePath) {
            do {
                try FileManager.default.createDirectory(atPath: cachePath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                debugPrint("create pinYin cache path error: \(error)")
                return nil
            }
        }
        return NSString(string: cachePath).appendingPathComponent(.unicodeToPinyin)
    }
    
    /// 缓存PinyinMap
    fileprivate static func cache(_ map: UnicodeToPinyinMap) {
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: map)
        guard let cachePath = pinyinCachePath else { return }
        
        DispatchQueue.global(qos: .default).async {
            do {
                try archivedData.write(to: URL(fileURLWithPath: cachePath), options: .atomicWrite)
            } catch let error {
                debugPrint("cache object error: \(error)")
            }
        }
    }
    
    /// 取出缓存的PinyinMap
    fileprivate static func cachedUnicodeToPinyinMap() -> UnicodeToPinyinMap? {
        guard let cachePath = pinyinCachePath else { return nil }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: cachePath), options: [])
            return NSKeyedUnarchiver.unarchiveObject(with: data) as? UnicodeToPinyinMap
        } catch _ {
            return nil
        }
    }
}

// MARK: - 拼音格式化

fileprivate struct NNPinyinFormatter {
    
    static func format(_ pinyin: String, withOutputFormat format: NNPinyinOutputFormat) -> String {
        var formattedPinyin = pinyin

        switch format.toneType {
        case .none:
            formattedPinyin = formattedPinyin.replacingOccurrences(
                of: "[1-5]",
                with: "",
                options: .regularExpression,
                range: formattedPinyin.startIndex..<formattedPinyin.endIndex
            )
        case .toneNumber: break
        }
        
        switch format.vCharType {
        case .vCharacter:
            formattedPinyin = formattedPinyin.replacingOccurrences(of: "u:", with: "v")
        case .uUnicode:
            formattedPinyin = formattedPinyin.replacingOccurrences(of: "u:", with: "ü")
        case .uAndColon: break
        }
        
        switch format.letterType {
        case .lowercased:
            formattedPinyin = formattedPinyin.lowercased()
        case .uppercased:
            formattedPinyin = formattedPinyin.uppercased()
        case .capitalized:
            formattedPinyin = formattedPinyin.capitalized
        }

        return formattedPinyin
    }
}
