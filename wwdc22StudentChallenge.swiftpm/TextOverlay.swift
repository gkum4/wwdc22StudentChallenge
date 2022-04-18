//
//  TextOverlay.swift.swift
//  PlaygroundsAppTests
//
//  Created by Gustavo Kumasawa on 16/04/22.
//

import SpriteKit

class TextOverlay {
    let node: SKNode
    let background: SKShapeNode
    let sceneFrame: CGRect
    private final let spaceWidth: CGFloat = 35
    private lazy var leftMargin: CGFloat = -sceneFrame.width/2 + 50
    
    init(frame: CGRect) {
        node = SKNode()
        node.zPosition = 100
        background = TextOverlay.buildBackground(frame: frame, color: .red)
        node.addChild(background)
        sceneFrame = frame
//        test()
    }
    
    // People change the way you think
    func showText1() {
        let label1 = TextOverlay.buildLabel("People change the")
        let label1PosX = leftMargin + label1.frame.width/2
        label1.position = CGPoint(x: label1PosX, y: 55)
        label1.name = LabelNames.peopleChangeThe

        let label2 = TextOverlay.buildLabel("way you")
        let label2PosX = leftMargin + label2.frame.width/2
        label2.position = CGPoint(x: label2PosX, y: -55)
        label2.name = LabelNames.wayYou

        let label3 = TextOverlay.buildLabel("think")
        let label3PosX = leftMargin + label3.frame.width/2 + label2.frame.width + spaceWidth
        label3.position = CGPoint(x: label3PosX, y: -55)
        label3.name = LabelNames.think

        node.addChild(label1)
        node.addChild(label2)
        node.addChild(label3)
    }
    
    // People change the way you see things
    func showText2() {
        guard let label3 = node.children.first(
            where: { $0.name == LabelNames.think }
        ) as? SKLabelNode else {
            return
        }
        
        guard let label2 = node.children.first(
            where: { $0.name == LabelNames.wayYou }
        ) as? SKLabelNode else {
            return
        }
        
        label3.run(.sequence([
            .group([
                .fadeOut(withDuration: 1),
                .move(by: CGVector(dx: 0, dy: -100), duration: 1)
            ]),
            .run {
                label3.removeFromParent()
            }
        ]))
        
        let label4 = TextOverlay.buildLabel("see things")
        let label4PosX = leftMargin + label4.frame.width/2 + label2.frame.width + spaceWidth
        label4.position = CGPoint(x: label4PosX, y: -55)
        label4.alpha = 0
        
        node.addChild(label4)
        
        label4.run(.sequence([
            .wait(forDuration: 0.2),
            .fadeIn(withDuration: 1)
        ]))
    }
    
    // Sometimes people have to leave (but that’s ok)
    func showText3() {
        
    }
    
    // The more you know, the more you see  what you don’t know
    func showText4() {
        
    }
    
    func showText5() {}
    
    static private func buildLabel(_ text: String, size: TextSize = .normal) -> SKLabelNode {
        let newLabel = SKLabelNode(text: text)
        
        switch size {
        case .normal:
            newLabel.fontName = FontNames.pingFangSemibold
            newLabel.fontSize = 91
        case .small:
            newLabel.fontName = FontNames.pingFangRegular
            newLabel.fontSize = 50
        }
        
        return newLabel
    }
    
    private enum TextSize {
        case normal
        case small
    }
    
    static private func buildBackground(frame: CGRect, color: UIColor) -> SKShapeNode {
        let newBackground = SKShapeNode(rectOf: frame.size)
        newBackground.strokeColor = .clear
        newBackground.fillColor = color
        newBackground.alpha = 0.8
        return newBackground
    }
    
    enum FontNames {
        static let pingFangRegular: String = "PingFangSC-Regular"
        static let pingFangSemibold: String = "PingFangSC-Semibold"
    }
    
    enum LabelNames {
        static let peopleChangeThe: String = "label1"
        static let wayYou: String = "label2"
        static let think: String = "label3"
        static let seeThings: String = "label4"
        static let sometimesPeople: String = "label5"
        static let butThat: String = "label6"
        static let theMore: String = "label7"
        static let theWorld: String = "label8"
    }
}
