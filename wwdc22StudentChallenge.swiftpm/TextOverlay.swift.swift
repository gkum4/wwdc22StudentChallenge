//
//  TextOverlay.swift.swift
//  PlaygroundsAppTests
//
//  Created by Gustavo Kumasawa on 16/04/22.
//

import SpriteKit

class TextOverlay {
    let node: SKNode
    let sceneFrame: CGRect
    
    init(frame: CGRect) {
        node = SKNode()
        node.zPosition = 100
        sceneFrame = frame
    }
}
