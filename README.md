# NNPinyin

 一个轻量级的Swift库，支持中文（简体和繁体）和拼音之间的转换。
 
<!--[![CI Status](https://img.shields.io/travis/YiHuaXie/NNPinyin.svg?style=flat)](https://travis-ci.org/YiHuaXie/NNPinyin)-->
[![Version](https://img.shields.io/cocoapods/v/NNPinyin.svg?style=flat)](https://cocoapods.org/pods/NNPinyin)
[![License](https://img.shields.io/cocoapods/l/NNPinyin.svg?style=flat)](https://cocoapods.org/pods/NNPinyin)
[![Platform](https://img.shields.io/cocoapods/p/NNPinyin.svg?style=flat)](https://cocoapods.org/pods/NNPinyin)

### How to use

#### Pinyin output format

```Swift
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

// 定义拼音输出格式
let outputFormat = NNPinyinOutputFormat(toneType: .toneNumber, vCharType: .uAndColon, letterType: .uppercased)
```

#### Convert to Pinyin

```Swift
debugPrint("绿色".toPinyin())
// "lv se"
var outputFormat = NNPinyinOutputFormat(vCharType: .uUnicode)
debugPrint("绿色".toPinyin(withFormat: outputFormat))
// "lü se"
outputFormat = NNPinyinOutputFormat(toneType: .toneNumber, vCharType: .uAndColon, letterType: .uppercased)
debugPrint("绿色".toPinyin(withFormat: outputFormat))
// "LU:4 SE4"
debugPrint("你在幹什麼".toPinyinAcronym())
// "nzgsm"
debugPrint("Hello".toPinyin())
// "Hello"
debugPrint("测试dasdasd".hasChineseCharacter)
// true
```

### Requirements

iOS 8.0

### Installation

```ruby
pod 'NNPinyin'
```

### Author

YiHuaXie, xyh30902@163.com

### License

NNPinyin is available under the MIT license. See the LICENSE file for more info.


