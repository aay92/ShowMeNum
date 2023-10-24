//
//  ColorApp.swift
//  ShowMeNum
//
//  Created by Aleksey Alyonin on 21.10.2023.
//
import UIKit

struct ColorApp {
    static let text = UIColor(hexString: "000000")
    
    struct ColorBack {
        static let bg = UIColor(hexString: "818181")
        static let bgBorder = UIColor(hexString: "333333")
    }
    
    struct ColorScreen {
        static let screenForNumbers = UIColor(hexString: "329090")
        static let screenForNumbersBorder = UIColor(hexString: "333333")
        
        static let screenForNumbersGradientUp = UIColor(hexString: "65aeae")
        static let screenForNumbersGradientDowm = UIColor(hexString: "008080")
    }
    
    struct ColorScreenNumber {
        static let colorNumbers = UIColor(hexString: "082923")
    }
    
    struct ColorPanel {
        static let bg = UIColor(hexString: "5d5d5d")
    }
}
