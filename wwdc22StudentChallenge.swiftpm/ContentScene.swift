//
//  GameScene.swift
//  PlaygroundsAppTests
//
//  Created by Gustavo Kumasawa on 11/04/22.
//

import SpriteKit

class ContentScene: SKScene {
    internal lazy var screenArea: CGFloat = {
        return self.frame.height * self.frame.width
    }()
    internal lazy var mainCircle: MainCircle = {
        let mainCircleArea = screenArea * 0.023
        let mainCircleRadius = sqrt(mainCircleArea / CGFloat.pi)
        return MainCircle(radius: mainCircleRadius)
    }()
    internal lazy var background: Background = Background(frame: self.frame)
    internal lazy var textOverlay: TextOverlay = TextOverlay(frame: self.frame)
    internal let numberOfCircles: Int = 25
    internal lazy var circleRadius: CGFloat = {
        let totalCircleArea = screenArea * 0.126
        let circleArea = totalCircleArea / CGFloat(numberOfCircles)
        return sqrt(circleArea / CGFloat.pi)
    }()
    internal var circles: [Circle] = []
    internal var lines: [Line] = []
    var testNode: SKNode!
    var startedTouchingNothing: Bool = false
    
    internal func findCircle(node: SKNode) -> Circle? {
        for circle in circles {
            if circle.node == node {
                return circle
            }
        }
        
        return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
}
