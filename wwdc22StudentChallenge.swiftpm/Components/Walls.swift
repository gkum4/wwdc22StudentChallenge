//
//  Walls.swift
//  PlaygroundsAppTests
//
//  Created by Gustavo Kumasawa on 12/04/22.
//

import SpriteKit

class Walls {
    let topNode: SKSpriteNode
    let bottomNode: SKSpriteNode
    let leftNode: SKSpriteNode
    let rightNode: SKSpriteNode
    
    init(frame: CGRect) {
        let topPhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.width, height: 1))
        topPhysicsBody.isDynamic = false
        topPhysicsBody.affectedByGravity = false
        
        let bottomPhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.width, height: 1))
        bottomPhysicsBody.isDynamic = false
        bottomPhysicsBody.affectedByGravity = false
        
        let leftPhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: frame.height))
        leftPhysicsBody.isDynamic = false
        leftPhysicsBody.affectedByGravity = false
        
        let rightPhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: frame.height))
        rightPhysicsBody.isDynamic = false
        rightPhysicsBody.affectedByGravity = false
        
        topNode = SKSpriteNode(color: .clear, size: CGSize(width: frame.width, height: 1))
        topNode.physicsBody = topPhysicsBody
        topNode.position = CGPoint(x: 0, y: frame.height/2)
        
        bottomNode = SKSpriteNode(color: .clear, size: CGSize(width: frame.width, height: 1))
        bottomNode.physicsBody = bottomPhysicsBody
        bottomNode.position = CGPoint(x: 0, y: -frame.height/2)
        
        leftNode = SKSpriteNode(color: .clear, size: CGSize(width: 1, height: frame.height))
        leftNode.physicsBody = leftPhysicsBody
        leftNode.position = CGPoint(x: -frame.width/2, y: 0)
        
        rightNode = SKSpriteNode(color: .clear, size: CGSize(width: 1, height: frame.height))
        rightNode.physicsBody = rightPhysicsBody
        rightNode.position = CGPoint(x: frame.width/2, y: 0)
    }
}
