//
//  Line.swift
//  PlaygroundsAppTests
//
//  Created by Gustavo Kumasawa on 13/04/22.
//

import SpriteKit

class Line {
    let node: SKNode
    let anchorCircleA: Circle
    let anchorCircleB: Circle
    var color: UIColor
    var line: SKShapeNode
    var detectableLine: SKSpriteNode
    var animationProgress: CGFloat = 0
    var completedAnimation: Bool = false
    var completeAnimationCallback: () -> Void = {}
    var isPaused: Bool = false
    static let normalWidth: CGFloat = 3
    
    init(
        anchorCircleA: Circle,
        anchorCircleB: Circle,
        color: UIColor
    ) {
        self.node = SKNode()
        
        self.anchorCircleA = anchorCircleA
        self.anchorCircleB = anchorCircleB
        self.color = color
        
        let (anchorAPos, anchorBPos) = Line.getAnchorsPositions(
            anchorA: anchorCircleA,
            anchorB: anchorCircleB,
            refNode: self.node
        )
        
        self.line = Line.buildLine(
            pointA: anchorAPos,
            pointB: anchorBPos,
            color: color
        )
        self.node.addChild(line)
        
        self.detectableLine = Line.buildDetectableLine(
            pointA: anchorCircleA.node.position,
            pointB: anchorCircleB.node.position
        )
        self.node.addChild(detectableLine)
    }
    
    func checkIfContains(_ pos: CGPoint) -> Bool {
        let anchorAPos = anchorCircleA.node.position
        let anchorBPos = anchorCircleB.node.position
        
        /*
         a = (ya - yb)
         b = (xb - xa)
         c = xa*yb - xb*ya
         ax + by + c = 0
         */
        let a = anchorAPos.y - anchorBPos.y
        let b = anchorBPos.x - anchorAPos.x
        let c = anchorAPos.x*anchorBPos.y - anchorBPos.x*anchorAPos.y
        let funcValue = (a*pos.x + b*pos.y + c)
        
        let isInsideLinearFuncion = (funcValue >= -400 && funcValue <= 400)
        
        return node.contains(pos) && isInsideLinearFuncion
    }
    
    func runChangeColorAnimation(to color: UIColor, withDuration duration: TimeInterval) {
        guard let newLine = line.copy() as? SKShapeNode else {
            return
        }
        
        newLine.alpha = 0
        newLine.strokeColor = color
        node.addChild(newLine)
        
        line.run(.sequence([
            .wait(forDuration: duration),
            .run {
                self.line.removeFromParent()
            }
        ]))
        
        newLine.run(.sequence([
            .fadeIn(withDuration: duration + 0.01),
            .run {
                self.line = newLine
            }
        ]))
    }
    
    func removeWithAnimation(onCompletion: @escaping () -> Void = {}) {
        isPaused = true
        
        node.run(.sequence([
            .fadeOut(withDuration: 1),
            .run {
                self.node.removeFromParent()
                onCompletion()
            }
        ]))
    }
    
    func update() {
        if isPaused {
            return
        }
        
        let (anchorAPos, anchorBPos) = Line.getAnchorsPositions(
            anchorA: anchorCircleA,
            anchorB: anchorCircleB,
            refNode: node
        )
        
        var endPos: CGPoint = anchorBPos
        
        if !completedAnimation {
            endPos = CGPoint.lerp(
                start: anchorAPos,
                end: anchorBPos,
                t: animationProgress
            )
            animationProgress += 0.05
            
            if animationProgress >= 1 {
                completedAnimation = true
                setLinePath(posA: anchorAPos, posB: endPos)
                completeAnimationCallback()
                return
            }
        }
        setLinePath(posA: anchorAPos, posB: endPos)
        detectableLine.removeFromParent()
        detectableLine = Line.buildDetectableLine(
            pointA: anchorAPos,
            pointB: endPos
        )
        node.addChild(detectableLine)
    }
    
    private func setLinePath(posA: CGPoint, posB: CGPoint) {
        let newPath = CGMutablePath()
        newPath.move(to: posA)
        newPath.addLine(to: posB)
        
        line.path = newPath
    }
    
    static private func buildLine(
        pointA: CGPoint,
        pointB: CGPoint,
        color: UIColor
    ) -> SKShapeNode {
        let line = SKShapeNode()
        line.strokeColor = color
        line.lineWidth = Line.normalWidth
        line.path = CGMutablePath()
        line.zPosition = 5
        return line
    }
    
    static private func buildDetectableLine(
        pointA: CGPoint,
        pointB: CGPoint
    ) -> SKSpriteNode {
        let angle = PositionUtils.getAngle(centerPoint: pointA, point: pointB)
        let distance = PositionUtils.getDistance(pointA: pointA, pointB: pointB)
        let newShapeNode = SKSpriteNode(
            color: .clear,
            size: CGSize(width: distance, height: Line.normalWidth)
        )
        newShapeNode.anchorPoint = .init(x: 0, y: 0.5)
        newShapeNode.zPosition = 4
        newShapeNode.zRotation = angle
        return newShapeNode
    }
    
    static private func getAnchorsPositions(
        anchorA: Circle,
        anchorB: Circle,
        refNode: SKNode
    ) -> (CGPoint, CGPoint) {
        let posA = refNode.convert(anchorA.circle.position, from: anchorA.node)
        let posB = refNode.convert(anchorB.circle.position, from: anchorB.node)
        
        return (posA, posB)
    }
}
