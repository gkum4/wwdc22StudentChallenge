//
//  MainCircle.swift
//  PlaygroundsAppTests
//
//  Created by Gustavo Kumasawa on 13/04/22.
//

import SpriteKit

class MainCircle: Circle {
    private var gradientColors: [CGColor] = []
    
    init(radius: CGFloat) {
        let circleColor = UIColor(named: "darkGray") ?? UIColor.darkGray
        
        super.init(radius: radius, color: circleColor, animated: false)
        
        node.name = Names.mainCircle
        circle.fillColor = circleColor
        circle.physicsBody?.isDynamic = false
    }
    
    override func runChangeColorAnimation(
        to newColor: UIColor,
        withDuration duration: TimeInterval,
        onCompletion: @escaping () -> Void = {}
    ) {
        if gradientColors.isEmpty {
            super.runChangeColorAnimation(
                to: newColor,
                withDuration: duration,
                onCompletion: onCompletion
            )
            
            gradientColors.append(newColor.cgColor)
            return
        }
        
        gradientColors.append(newColor.cgColor)
        
        guard let newCircle = circle.copy() as? SKShapeNode else {
            return
        }
        
        newCircle.fillTexture = SKTexture(image: buildGradientImage())
        newCircle.alpha = 0
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
    
    private func buildGradientImage() -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = circle.frame
        gradientLayer.colors = gradientColors
        gradientLayer.type = .radial
        gradientLayer.startPoint = CGPoint(x: 1, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        guard let currentContext = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return UIImage()
        }
        gradientLayer.render(in: currentContext)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return UIImage()
        }
        
        UIGraphicsGetCurrentContext()
        return image
    }
    
    enum Names {
        static let mainCircle: String = "mainCircle"
    }
}
