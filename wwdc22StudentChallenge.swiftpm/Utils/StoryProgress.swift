//
//  StoryProgress.swift
//  wwdc22StudentChallenge
//
//  Created by Gustavo Kumasawa on 18/04/22.
//

import Foundation

protocol StoryProgressDelegate: AnyObject {
    func showText()
}

class StoryProgress {
    var canCreateConnection: Bool = true
    var canTapOnConnection: Bool = false
    var canCutConnectionLine: Bool = false
    var canZoomInOrZoomOut: Bool = false
    var canCreateDistantConnection: Bool = false
    weak var delegate: StoryProgressDelegate?
    
    init(delegate: StoryProgressDelegate) {
        self.delegate = delegate
    }
    
    private var _step: Int = 0
    var step: Int {
        get {
            return _step
        }
        set {
            switch newValue {
            case 1:
                canTapOnConnection = true
            case 2:
                canCutConnectionLine = true
            case 3:
                canZoomInOrZoomOut = true
            case 4:
                canCreateDistantConnection = true
            default:
                _step = newValue
                return
            }
            
            delegate?.showText()
            _step = newValue
        }
    }
    
    func createdConnection() {
        if step != 0 {
            return
        }
        
        step += 1
    }
    
    func tappedOnConnection() {
        if step != 1 {
            return
        }
        
        step += 1
    }
    
    func cutConnectionLine() {
        if step != 2 {
            return
        }
        
        step += 1
    }
    
    func zoomedOut() {
        if step != 3 {
            return
        }
        
        step += 1
    }
    
    func createdDistantConection() {
        if step != 4 {
            return
        }
        
        step += 1
    }
}
