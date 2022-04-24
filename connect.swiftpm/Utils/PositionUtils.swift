//
//  PositionUtils.swift
//  PlaygroundsAppTests
//
//  Created by Gustavo Kumasawa on 12/04/22.
//

import CoreGraphics

class PositionUtils {
    static func getRandomPosition(
        xRange: ClosedRange<CGFloat>,
        yRange: ClosedRange<CGFloat>
    ) -> CGPoint {
        return CGPoint(
            x: CGFloat.random(in: xRange),
            y: CGFloat.random(in: yRange)
        )
    }
    
    static func getRandomVector(
        xRange: ClosedRange<CGFloat>,
        yRange: ClosedRange<CGFloat>
    ) -> CGVector {
        return CGVector(
            dx: CGFloat.random(in: xRange),
            dy: CGFloat.random(in: yRange)
        )
    }
    
    static func getDistance(pointA: CGPoint, pointB: CGPoint) -> CGFloat {
        return sqrt(pow(pointB.x - pointA.x, 2) + pow(pointB.y - pointA.y, 2))
    }
    
    static func getAngle(centerPoint: CGPoint, point: CGPoint) -> CGFloat {
        let xDifference = abs(abs(point.x) - abs(centerPoint.x))
        let yDifference = abs(abs(point.y) - abs(centerPoint.y))
        
        if point.x >= centerPoint.x && point.y >= centerPoint.y {
            // topo direita
            return atan(yDifference/xDifference)
        }
        
        if point.x <= centerPoint.x && point.y >= centerPoint.y {
            // topo esquerda
            return atan(yDifference/xDifference) + CGFloat.pi/2
        }
        
        if point.x <= centerPoint.x && point.y <= centerPoint.y {
            // baixo esquerda
            return atan(xDifference/yDifference) + CGFloat.pi
        }
        
        if point.x >= centerPoint.x && point.y <= centerPoint.y {
            // baixo direita
            return atan(xDifference/yDifference) + CGFloat.pi*1.5
        }
        
        return 0
    }
}
