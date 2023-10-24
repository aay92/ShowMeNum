//
//  LabelFabric.swift
//  ShowMeNum
//
//  Created by Aleksey Alyonin on 22.10.2023.
//

import UIKit

struct LabelFabric {
    static func build(text: String?,
                      font: UIFont,
                      backgruondColor:
                      UIColor = .clear,
                      textColor: UIColor = ColorApp.text,
                      textAligment: NSTextAlignment = .center, lineOfNumber: Int = 0) -> UILabel {
        
        let label = UILabel()
        label.text = text
        label.font = font
        label.backgroundColor = backgruondColor
        label.textColor = textColor
        label.textAlignment = textAligment
        label.numberOfLines = lineOfNumber
        return label
    }
}
