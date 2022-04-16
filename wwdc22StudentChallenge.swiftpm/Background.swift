//
//  Background.swift
//  PlaygroundsAppTests
//
//  Created by Gustavo Kumasawa on 13/04/22.
//

import SpriteKit

class Background {
    let node: SKNode
    let sceneFrame: CGRect
    
    init(frame: CGRect) {
        node = SKNode()
        node.zPosition = 0
        sceneFrame = frame
    }
    
    func runSpreadAnimation(color: UIColor, atPos pos: CGPoint = .zero) {
        let firstCircleRadius = sceneFrame.height/2/5 + 20
        
        for i in 1...6 {
            let circle = SKShapeNode(circleOfRadius: 1)
            circle.alpha = 0.05
            circle.strokeColor = .clear
            circle.fillColor = color
            circle.position = pos
            
            node.addChild(circle)
            
            let circleAnimation: SKAction = .sequence([
                .scale(to: firstCircleRadius * CGFloat(i), duration: CGFloat(i) * 0.1),
                .fadeOut(withDuration: 1),
                .run {
                    circle.removeFromParent()
                }
            ])
            circle.run(circleAnimation)
        }
    }
}
