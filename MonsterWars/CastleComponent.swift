//
//  CastleComponent.swift
//  MonsterWars
//
//  Created by Clavel Tosco on 9/27/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

class CastleComponent: GKComponent {
    
    //this stores the number of coins in the castle, and the last time coins were earned
    var coins = 0
    var lastCoinDrop = NSTimeInterval(0)
    
    override init() {
        super.init()
    }
    
    //this method will be called on each frame of the game. Note this is not called by default; you have to do a little but of setup to get this to happen, which you'll do shortly
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        super.updateWithDeltaTime(seconds)
        
        //this spawns coins periodically
        let coinDropInterval = NSTimeInterval(0.5)
        let coinsPerInterval = 10
        if (CACurrentMediaTime() - lastCoinDrop > coinDropInterval) {
            lastCoinDrop = CACurrentMediaTime()
            coins += coinsPerInterval
        }
    }
}
