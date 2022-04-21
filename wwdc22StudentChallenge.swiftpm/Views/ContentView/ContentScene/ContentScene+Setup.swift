//
//  ContentScene+Setup.swift
//  PlaygroundsAppTests
//
//  Created by Gustavo Kumasawa on 13/04/22.
//

import SpriteKit

extension ContentScene {
    override func didMove(to view: SKView) {
        setupScene()
    }
    
    private func setupScene() {
//        self.addChild(Walls(frame: self.frame))
        self.addChild(mainCircle)
        placeCircles()
        self.addChild(background)
        self.addChild(textOverlay)
        self.addChild(contentCamera)
        self.camera = contentCamera.node
    }
    
    private func placeCircles() {
        let screenXRange = (-self.size.width/2 + 10)...(self.size.width/2 - 10)
        let screenYRange = (-self.size.height/2 + 10)...(self.size.height/2 - 10)
        let color = ColorSequence.shared.actualColor
        
        for _ in 1...numberOfCircles {
            let radius = circleRadius * CGFloat.random(in: 0.5...1)
            
            let circle = Circle(radius: radius, color: color, animated: true)
            circle.node.position = getUsusedPositionToPlaceCircle(
                xRange: screenXRange,
                yRange: screenYRange
            )
            
            circles.append(circle)
            self.addChild(circle)
        }
    }
    
    private func getUsusedPositionToPlaceCircle(
        xRange: ClosedRange<CGFloat>,
        yRange: ClosedRange<CGFloat>
    ) -> CGPoint {
        var newPosition = PositionUtils.getRandomPosition(
            xRange: xRange,
            yRange: yRange
        )
        
        while !checkHasMinimunDistanceFromCircles(atPos: newPosition, dist: 120) {
            newPosition = PositionUtils.getRandomPosition(
                xRange: xRange,
                yRange: yRange
            )
        }
        
        return newPosition
    }
    
    private func checkHasMinimunDistanceFromCircles(atPos pos: CGPoint, dist: CGFloat) -> Bool {
        for node in self.children {
            if node.name != Circle.Names.circle && node.name != MainCircle.Names.mainCircle {
                continue
            }
            
            let distance = PositionUtils.getDistance(pointA: node.position, pointB: pos)
            
            if distance <= dist {
                return false
            }
        }
        
        return true
    }
}

// ideias Gui: - bolinhas que se aproximam do centro qnd tocadas - usar acelerometro
