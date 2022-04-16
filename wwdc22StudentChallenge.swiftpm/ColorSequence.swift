//
//  ColorSequence.swift
//  PlaygroundsAppTests
//
//  Created by Gustavo Kumasawa on 13/04/22.
//

import UIKit

class ColorSequence {
    static let shared = ColorSequence()
    
    var actualColor: UIColor
    private var actualColorIndex: Int = 0
    private let colorSequence: [UIColor] = [
        UIColor(named: "gray") ?? UIColor.gray,
        UIColor(named: "purpleish") ?? UIColor.gray,
        UIColor(named: "redish") ?? UIColor.gray,
        UIColor(named: "yellowish") ?? UIColor.gray,
        UIColor(named: "pinkish") ?? UIColor.gray,
        UIColor(named: "orangeish") ?? UIColor.gray,
        UIColor(named: "greenish") ?? UIColor.gray,
        UIColor(named: "blueish") ?? UIColor.gray,
    ]
    
    private init() {
        actualColor = colorSequence[actualColorIndex]
    }
    
    func next() {
        if actualColorIndex < colorSequence.count-1 {
            actualColorIndex += 1
            actualColor = colorSequence[actualColorIndex]
            return
        }
        
        actualColor = colorSequence[Int.random(in: 0...(colorSequence.count-1))]
    }
}
