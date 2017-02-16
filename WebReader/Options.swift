//
//  Options.swift
//  WebReader
//
//  Created by Wayne Chang on 2017/2/12.
//  Copyright © 2017年 WayneChang. All rights reserved.
//

import Foundation



enum OptionType: String {
    case picker = "Picker"
    case switcher = "Switch"
}


func getAtRowNum(currentOption: String, arrayOption: [String]) -> Int {
    for i in 0..<arrayOption.count {
        if arrayOption[i] == currentOption {
            return i
        }
    }
    // never gonna come here
    return 0;
}

var fontColorOptions = ["black", "white", "gray"];
var fontSizeOptions = ["18", "20", "22", "24", "26", "28", "30", "32"];


func getParameters(keyName: String) -> ( String, [String]) {
    switch keyName {
    case "FontColor":
        let currentOption = UserDefaults.standard.string(forKey: "FontColor")
        return (currentOption!, fontColorOptions)
    case "FontSize":
        let currentOption = UserDefaults.standard.integer(forKey: "FontSize")
        return (String(currentOption), fontSizeOptions)
    default:
        return( "some wrong happenned", [])
    }
}

class Options {
    let optionName: String?
    let type: OptionType
    let keyName: String?
    
    init(name: String, type: OptionType, key: String) {
        self.type = type
        self.optionName = name
        self.keyName = key
    }
}


class PickerOptions: Options {
    var pickerName: String!
    var value: [String?]
    
    init(_ name: String!, _ val: [String?], keyName: String!) {
        self.value = val;
        super.init(name: name, type: .picker, key: keyName)
    }
}

class SwitcherOptions: Options {
    var value: Bool
    init(_ name: String!, _ val: Bool, keyName: String!) {
        self.value = val
        super.init(name: name, type: .switcher, key:keyName)
    }
}
