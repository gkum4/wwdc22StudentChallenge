//
//  Camera.swift
//  wwdc22StudentChallenge
//
//  Created by Gustavo Kumasawa on 19/04/22.
//

import SpriteKit

class ContentCamera {
    let node: SKCameraNode
    let sceneFrame: CGRect
    var scaleValue: CGFloat = 1
    
    init(frame: CGRect) {
        node = SKCameraNode()
        sceneFrame = frame
    }
    
    func update() {
        node.setScale(scaleValue)
    }
    
    func zoomIn() {
        
    }
    
    func zoomOut() {
        
    }
}
