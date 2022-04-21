//
//  ContentScene+Touches.swift
//  PlaygroundsAppTests
//
//  Created by Gustavo Kumasawa on 13/04/22.
//

import SpriteKit

extension ContentScene {
    internal func touchDown(atPoint pos: CGPoint) {
        guard let nodeTouched = getTouchedNode(atPos: pos) else {
            startedTouchingNothing = true
            return
        }

        if nodeTouched.name == Circle.Names.circle {
            onTouchCircle(nodeTouched: nodeTouched)
            return
        }

        if nodeTouched.name == MainCircle.Names.mainCircle {
            onTouchMainCircle(nodeTouched: nodeTouched)
            return
        }

        startedTouchingNothing = true
    }
    
    private func onTouchCircle(nodeTouched: SKNode) {
        if !storyProgress.canCreateConnection {
            return
        }
        
        guard let circleTouched = findCircle(node: nodeTouched) else {
            return
        }
        
        if circleTouched.hasLineAttached && storyProgress.canTapOnConnection {
            background.runSpreadAnimation(
                color: circleTouched.circle.fillColor,
                atPos: circleTouched.node.position,
                onCompletion: storyProgress.tappedOnConnection
            )
            return
        }
        circleTouched.hasLineAttached = true
        
        drawLine(circleA: mainCircle, circleB: circleTouched, onCompletion: {
            self.storyProgress.createdConnection()
        })
    }
    
    private func onTouchMainCircle(nodeTouched: SKNode) {
        if nodeTouched != mainCircle.node {
            return
        }
        
//        guard let mainCircleTexture = mainCircle.circle.fillTexture else {
//            return
//        }
        
        background.runSpreadAnimation(
            colors: mainCircle.gradientColors
        )
        
        testNode = nodeTouched
    }
    
    func showText() {
        textOverlay.show(onCompletion: {
            self.textOverlay.nextStep(onCompletion: {
                self.textOverlay.wait(forDuration: 1, onCompletion: {
                    self.textOverlay.hide()
                })
            })
        })
    }
    
    private func getTouchedNode(atPos pos: CGPoint) -> SKNode? {
        for node in self.children {
            if node.contains(pos) {
                return node
            }
        }
        
        return nil
    }
    
    private func drawLine(
        circleA: Circle,
        circleB: Circle,
        onCompletion: @escaping () -> Void = {}
    ) {
        circleA.pauseMovingAnimation()
        circleB.pauseMovingAnimation()
        
        let lineColor = ColorSequence.shared.actualColor
        ColorSequence.shared.next()
        let newColor = ColorSequence.shared.actualColor
        
        let line = Line(
            anchorCircleA: circleA,
            anchorCircleB: circleB,
            color: lineColor
        )
        line.completeAnimationCallback = {
            self.background.runSpreadAnimation(color: newColor)
            line.runChangeColorAnimation(to: newColor, withDuration: 1)
            circleA.runChangeColorAnimation(to: newColor, withDuration: 1)
            circleB.runChangeColorAnimation(to: newColor, withDuration: 1, onCompletion: {
                circleA.continueMovingAnimation()
                circleB.continueMovingAnimation()
                onCompletion()
            })
        }
        
        lines.append(line)
        self.addChild(line)
    }
    
    internal func touchMoved(toPoint pos: CGPoint) {
        if testNode != nil {
            testNode.position = pos
        }
        
        if startedTouchingNothing && storyProgress.canCutConnectionLine {
            if checkIfIsTouchingAnyCircle(atPos: pos) {
                return
            }
            
            guard let (touchedLine, touchedLineIndex) = getLineWhileTouchMoving(atPos: pos) else {
                return
            }
            
            cutLine(touchedLine: touchedLine, touchedLineIndex: touchedLineIndex, onCompletion: {
                self.storyProgress.cutConnectionLine()
            })
        }
    }
    
    private func checkIfIsTouchingAnyCircle(atPos pos: CGPoint) -> Bool {
        if mainCircle.circle.contains(self.convert(pos, to: mainCircle.node)) {
            return true
        }
        
        for circle in circles {
            if circle.circle.contains(self.convert(pos, to: circle.node)) {
                return true
            }
        }
        
        return false
    }
    
    private func cutLine(
        touchedLine: Line,
        touchedLineIndex: Int,
        onCompletion: @escaping () -> Void = {}
    ) {
        if !touchedLine.completedAnimation {
            return
        }
        
        let anchorCircleA = touchedLine.anchorCircleA
        let anchorCircleB = touchedLine.anchorCircleB
        
        anchorCircleA.pauseMovingAnimation()
        anchorCircleB.pauseMovingAnimation()
        touchedLine.removeWithAnimation(completeAnimationCallback: {
            anchorCircleA.hasLineAttached = false
            anchorCircleB.hasLineAttached = false
            
            if !(anchorCircleA is MainCircle) {
                anchorCircleA.runMoveAwayAnimation(completeAnimationCallback: {
                    anchorCircleA.continueMovingAnimation()
                    onCompletion()
                })
            }
            
            if !(anchorCircleB is MainCircle) {
                anchorCircleB.runMoveAwayAnimation(completeAnimationCallback: {
                    anchorCircleB.continueMovingAnimation()
                    onCompletion()
                })
            }
        })
        
        lines.remove(at: touchedLineIndex)
    }
    
    private func getLineWhileTouchMoving(atPos pos: CGPoint) -> (Line, Int)? {
        for (i, line) in lines.enumerated() {
            if line.node.contains(pos) {
                return (line, i)
            }
        }
        
        return nil
    }
    
    internal func touchUp(atPoint pos: CGPoint) {
        testNode = nil
        startedTouchingNothing = false
    }
}
