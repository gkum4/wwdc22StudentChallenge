//
//  MainCircle.swift
//  PlaygroundsAppTests
//
//  Created by Gustavo Kumasawa on 13/04/22.
//

import SpriteKit

class MainCircle: Circle {
    init(radius: CGFloat) {
        let circleColor = UIColor(named: "darkGray") ?? UIColor.darkGray
        
        super.init(radius: radius, color: circleColor, animated: false)
        
        node.name = Names.mainCircle
        circle.fillColor = circleColor
        circle.physicsBody?.isDynamic = false
    }
    
    enum Names {
        static let mainCircle: String = "mainCircle"
    }
}
