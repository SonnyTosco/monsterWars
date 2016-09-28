//
//  Castle.swift
//  MonsterWars
//
//  Created by Clavel Tosco on 9/27/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import SpriteKit
import GameplayKit
// it's often convenient to subclass GKEntity for each type of object in your game. The lternative is to create a base GKEntity and dynamically add the types of components you need; but often you want to have a "cookie cutter" for a particular type of object. That is what below is
class Castle: GKEntity {
    
    init(imageName: String, team: Team, entityManager: EntityManager) {
        super.init()
        // you add just one component to the entity- the sprite component you just created. You'll be ading more components to this entity soon. 
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        addComponent(spriteComponent)
        addComponent(TeamComponent(team: team))
        addComponent(CastleComponent())
        addComponent(MoveComponent(maxSpeed: 0, maxAcceleration: 0, radius: Float(spriteComponent.node.size.width / 2), entityManager: entityManager))
    }
}
