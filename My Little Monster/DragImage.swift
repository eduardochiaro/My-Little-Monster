//
//  DragImage.swift
//  My Little Monster
//
//  Created by Eduardo Chiaro on 12/3/16.
//  Copyright © 2016 Eduardo Chiaro. All rights reserved.
//

import Foundation
import UIKit

class DragImage: UIImageView {
    
    private var _originalPosition: CGPoint!
    private var _dropTarget: UIView?
    
    var dropTarget: UIView? {
        set {
            _dropTarget = newValue
        }
        get {
            return _dropTarget
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecor: NSCoder){
        super.init(coder: aDecor)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        _originalPosition = self.center
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self.superview)
            self.center = CGPoint(x: position.x, y: position.y)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first, let target = _dropTarget {
            
            let position = touch.location(in: self.superview)
            
            if target.frame.contains(position) {
                
                NotificationCenter.default.post(Notification(name: Notification.Name("onTargetDropped")))
            }
        }
        
        self.center = _originalPosition
        
        
    }
    
}
