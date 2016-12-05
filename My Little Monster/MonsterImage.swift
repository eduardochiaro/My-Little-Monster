//
//  MonsterImg.swift
//  My Little Monster
//
//  Created by Eduardo Chiaro on 12/4/16.
//  Copyright © 2016 Eduardo Chiaro. All rights reserved.
//

import Foundation
import UIKit

class MonsterImage: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecor: NSCoder){
        super.init(coder: aDecor)
        PlayIdleAnimation()
    }
    
    func PlayIdleAnimation() {
        
        self.image = UIImage(named: "idle1.png")
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        
        for x in 1...4 {
            imgArray.append(UIImage(named: "idle\(x).png")!)
        }
        
        //var img1 = UIImage(named: "idle1.png")
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        
        self.startAnimating()
    }
    
    func PlayDeathAnimation() {
        
        self.image = UIImage(named: "dead5.png")
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        
        for x in 1...5 {
            imgArray.append(UIImage(named: "dead\(x).png")!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        
        self.startAnimating()
    }

}
