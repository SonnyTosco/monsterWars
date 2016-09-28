//
//  EntityManager.swift
//  MonsterWars
//
//  Created by Clavel Tosco on 9/27/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class EntityManager {
    
    // this class will kee a reference to all entities in the game, along with the scene
    var entities = Set<GKEntity>()
    let scene: SKScene
    var toRemove = Set<GKEntity>()
    
    // this is a simple initializer that stores the scene in the property you created
    init(scene: SKScene) {
        self.scene = scene
    }
    
    // this is a helper function that you will call when you want to add an entity to your game. It adds it to the list of entities, and then check to see if the entity has a SpriteComponent. If it does, it adds the sprite's node to the scene.
    func add(entity: GKEntity) {
        entities.insert(entity)
        
        if let spriteNode = entity.componentForClass(SpriteComponent.self)?.node {
            scene.addChild(spriteNode)
        }
        for componentSystem in componentSystems {
            componentSystem.addComponentWithEntity(entity)
        }
    }
    
    // this is a helper function that you will call when you want to remove an entity from your game. This does the opposite of the add(_:) method; if the entiy has a Spritecomponent, it removes the node from the scene and it also removes the entity from the list of entities. 
    func remove(entity: GKEntity) {
        if let spriteNode = entity.componentForClass(SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }
        entities.remove(entity)
        toRemove.insert(entity)
    }
    
    func update(deltaTime: CFTimeInterval) {
        
        //here you loop thrugh all the component systems in the array and call updateWithDeltaTime(_:) on each one. 
        for componentSystem in componentSystems {
            componentSystem.updateWithDeltaTime(deltaTime)
        }
        
        //here you loop thru anything in the toRemove array and remove those entities from the component systems
        for curRemove in toRemove {
            for componentSystem in componentSystems {
                componentSystem.removeComponentWithEntity(curRemove)
            }
        }
        toRemove.removeAll()
    }
    
    func castleForTeam(team: Team) -> GKEntity? {
        for entity in entities {
            if let teamComponent = entity.componentForClass(TeamComponent.self),
                _ = entity.componentForClass(CastleComponent.self) {
                if teamComponent.team == team {
                    return entity
                }
            }
        }
        return nil
    }
    
    func spawnQuirk(team: Team) {
        
        //monsters should be spawned near their team's castle. To do this, you need this postion of the castle's sprite, so this is some code to look up that information in a dynamic way.
        guard let teamEntity = castleForTeam(team),
            teamCastleComponent = teamEntity.componentForClass(CastleComponent.self),
            teamSpriteComponent = teamEntity.componentForClass(SpriteComponent.self) else {
                return
        }
        
        //this checks to see if there are enough coins to spawn the monster, and if so subtracts the appropriate coins and plays a sound
        if teamCastleComponent.coins < costQuirk {
            return
        }
        teamCastleComponent.coins -= costQuirk
        scene.runAction(SoundManager.sharedInstance.soundSpawn)
        
        //this is the code to create a Quirk entity and position it near the castle (at a random y-value)
        let monster = Quirk(team: team, entityManager: self)
        if let spriteComponent = monster.componentForClass(SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: teamSpriteComponent.node.position.x, y: CGFloat.random(min: scene.size.height*0.25, max: scene.size.height*0.75))
            spriteComponent.node.zPosition = 2
        }
        add(monster)
    }
    
    func entitiesForTeam(team: Team) -> [GKEntity] {
        return entities.flatMap{ entity in
            if let teamComponent = entity.componentForClass(TeamComponent.self) {
                if teamComponent.team == team {
                    return entity
                }
            }
            return nil
        }
    }
    
    func moveComponentsForTeam(team: Team) -> [MoveComponent] {
        let entities = entitiesForTeam(team)
        var moveComponents = [MoveComponent]()
        for entity in entities {
            if let moveComponent = entity.componentForClass(MoveComponent.self) {
                moveComponents.append(moveComponent)
            }
        }
        return moveComponents
    }
    
    lazy var componentSystems: [GKComponentSystem] = {
        let castleSystem = GKComponentSystem(componentClass: CastleComponent.self)
        let moveSystem = GKComponentSystem(componentClass: MoveComponent.self)
        return [castleSystem, moveSystem]
    }()
    
}