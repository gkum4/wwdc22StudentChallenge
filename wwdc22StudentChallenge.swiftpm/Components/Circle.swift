//
//  File.swift
//  PlaygroundsAppTests
//
//  Created by Gustavo Kumasawa on 12/04/22.
//

import SpriteKit

class Circle {
    let node: SKNode
    var circle: SKShapeNode
    var hasLineAttached: Bool = false
    
    init(radius: CGFloat, color: UIColor, animated: Bool) {
        self.node = SKNode()
        self.node.name = Names.circle
        self.circle = Circle.buildCircle(radius: radius, color: color)
        self.node.addChild(self.circle)
        
        if animated {
            self.node.run(Circle.buildMovingAnimation(), withKey: ActionKeys.movingAnimation)
        }
    }
    
    func pauseMovingAnimation() {
        guard let movingAnimation = self.node.action(forKey: ActionKeys.movingAnimation) else {
            return
        }
        
        movingAnimation.speed = 0
    }
    
    func continueMovingAnimation() {
        guard let movingAnimation = self.node.action(forKey: ActionKeys.movingAnimation) else {
            return
        }
        
        movingAnimation.speed = 1
    }
    
    func runChangeColorAnimation(
        to newColor: UIColor,
        withDuration duration: TimeInterval,
        onCompletion: @escaping () -> Void = {}
    ) {
        guard let newCircle = circle.copy() as? SKShapeNode else {
            return
        }
        
        newCircle.alpha = 0
        newCircle.fillColor = newColor
        node.addChild(newCircle)
        
        circle.run(.sequence([
            .wait(forDuration: duration),
            .run {
                self.circle.removeFromParent()
            }
        ]))
        
        newCircle.run(.sequence([
            .fadeIn(withDuration: duration+0.01),
            .run {
                self.circle = newCircle
                onCompletion()
            }
        ]))
    }
    
    func runMoveAwayAnimation(completeAnimationCallback: @escaping () -> Void = {}) {
        let position = node.position
        let absPosX = abs(position.x)
        let absPosY = abs(position.y)
        var xMultiplier: CGFloat = 0
        var yMultiplier: CGFloat = 0
        
        if absPosX > absPosY {
            xMultiplier = position.x > 0 ? 1 : -1
            yMultiplier = (absPosY / absPosX) * (position.y > 0 ? 1 : -1)
        }
        
        if absPosX < absPosY {
            xMultiplier = (absPosX / absPosY) * (position.x > 0 ? 1 : -1)
            yMultiplier = position.y > 0 ? 1 : -1
        }
        
        if absPosX == absPosY {
            xMultiplier = position.x > 0 ? 1 : -1
            yMultiplier = position.y > 0 ? 1 : -1
        }
        
        let moveAction: SKAction = .move(
            by: CGVector(dx: 20 * xMultiplier, dy: 20 * yMultiplier),
            duration: 1
        )
        moveAction.timingMode = .easeInEaseOut
        
        self.node.run(.sequence([
            moveAction,
            .run {
                completeAnimationCallback()
            }
        ]))
    }
    
    static private func buildCircle(radius: CGFloat, color: UIColor) -> SKShapeNode {
        let newCircle = SKShapeNode(circleOfRadius: radius)
        newCircle.strokeColor = .clear
        newCircle.fillColor = color
        newCircle.name = Names.circle
        newCircle.zPosition = 10
        
        let physicsBody = SKPhysicsBody(circleOfRadius: radius)
        physicsBody.affectedByGravity = false
        physicsBody.restitution = 0.5
        newCircle.physicsBody = physicsBody
        
        return newCircle
    }
    
    static private func buildMovingAnimation() -> SKAction {
        var circleAnimationSequence: [SKAction] = []
        var goBackVector = CGVector()
        
        for i in 1...3 {
            let randomVector: CGVector = PositionUtils.getRandomVector(
                xRange: -10...10,
                yRange: -10...10
            )
            
            circleAnimationSequence.append(
                .move(by: randomVector, duration: TimeInterval.random(in: 1...2))
            )
            
            goBackVector.dx -= randomVector.dx
            goBackVector.dy -= randomVector.dy
            
            if i == 3 {
                circleAnimationSequence.append(
                    .move(by: goBackVector, duration: TimeInterval.random(in: 1...2))
                )
            }
        }
        
        let animation: SKAction = .repeatForever(.sequence(circleAnimationSequence))
        animation.timingMode = .easeInEaseOut
        return animation
    }
    
    enum Names {
        static let circle: String = "circle"
    }
    
    enum ActionKeys {
        static let movingAnimation: String = "movingAnimation"
    }
}
