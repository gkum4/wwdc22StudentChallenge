//
//  SKScene+.swift
//  PlaygroundsAppTests
//
//  Created by Gustavo Kumasawa on 12/04/22.
//

import SpriteKit

extension SKScene {
    func addChild(_ mainCircle: MainCircle) {
        self.addChild(mainCircle.node)
    }
    
    func addChild(_ circle: Circle) {
        self.addChild(circle.node)
    }
    
    func addChild(_ walls: Walls) {
        self.addChild(walls.topNode)
        self.addChild(walls.bottomNode)
        self.addChild(walls.leftNode)
        self.addChild(walls.rightNode)
    }
    
    func addChild(_ line: Line) {
        self.addChild(line.node)
    }
    
    func addChild(_ background: Background) {
        self.addChild(background.node)
    }
}
