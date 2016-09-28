//
//  SpriteComponent.kit.swift
//  MonsterWars
//
//  Created by Clavel Tosco on 9/27/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

// To use GameplayKit you must import it just like you do for SpriteKit
import SpriteKit
import GameplayKit
// to create a GameplayKit component, simply subclass GKComponent
class SpriteComponent: GKComponent {
    // this component will keep track of a sprite, so you declare a property for one here
    let node: SKSpriteNode
    // this is a simple initializer that initializes the sprite based on a texture you pass in. 
    init(texture: SKTexture) {
        node = SKSpriteNode(texture: texture, color: SKColor.whiteColor(), size: texture.size())
    }
}
