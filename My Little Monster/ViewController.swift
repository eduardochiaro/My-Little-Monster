//
//  ViewController.swift
//  My Little Monster
//
//  Created by Eduardo Chiaro on 12/3/16.
//  Copyright © 2016 Eduardo Chiaro. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImg: MonsterImage!
    @IBOutlet weak var heartImage: DragImage!
    @IBOutlet weak var foodImage: DragImage!
    //@IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var penalty1Img: UIImageView!
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penalty3Img: UIImageView!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTY: Int = 3
    var currentPenalties = 0
    var monsterHappy = true
    var currentItem: UInt32 = 0
    
    var timer: Timer!
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        
        heartImage.dropTarget = monsterImg
        foodImage.dropTarget = monsterImg
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.itemDroppedOnCharacters), name: Notification.Name("onTargetDropped"), object: nil)
        
        startTimer()
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "cave-music", ofType: "mp3")!))
            try sfxBite = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "bite", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "heart", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "death", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxSkull.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    func itemDroppedOnCharacters(notif: AnyObject) {
        if currentItem == 0 {
            sfxHeart.play()
        } else {
            sfxBite.play()
        }
        monsterHappy = true
        startTimer()
        
        foodImage.alpha = DIM_ALPHA
        foodImage.isUserInteractionEnabled = false
        
        heartImage.alpha = DIM_ALPHA
        heartImage.isUserInteractionEnabled = false
   
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        
        if !monsterHappy {
            currentPenalties+=1
            sfxSkull.play()
            if currentPenalties == 1 {
                penalty1Img.alpha = OPAQUE
                penalty2Img.alpha = DIM_ALPHA
                penalty3Img.alpha = DIM_ALPHA
            } else if currentPenalties == 2 {
                penalty1Img.alpha = OPAQUE
                penalty2Img.alpha = OPAQUE
                penalty3Img.alpha = DIM_ALPHA
            } else if currentPenalties == 3 {
                penalty1Img.alpha = OPAQUE
                penalty2Img.alpha = OPAQUE
                penalty3Img.alpha = OPAQUE
            } else {
                penalty1Img.alpha = DIM_ALPHA
                penalty2Img.alpha = DIM_ALPHA
                penalty3Img.alpha = DIM_ALPHA
            }
            
            if currentPenalties >= MAX_PENALTY {
                gameOver()
            }
        }
        
        let rand = arc4random_uniform(2)  // 0 or 1
        
        if rand == 0 {
            foodImage.alpha = DIM_ALPHA
            foodImage.isUserInteractionEnabled = false
            
            heartImage.alpha = OPAQUE
            heartImage.isUserInteractionEnabled = true
        } else {
            foodImage.alpha = OPAQUE
            foodImage.isUserInteractionEnabled = true
            
            heartImage.alpha = DIM_ALPHA
            heartImage.isUserInteractionEnabled = false
        }
        currentItem = rand
        monsterHappy = false
    }
    
    func gameOver() {
        timer.invalidate()
        sfxDeath.play()
        monsterImg.PlayDeathAnimation()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

