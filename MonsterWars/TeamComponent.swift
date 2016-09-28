//
//  TeamComponent.swift
//  MonsterWars
//
//  Created by Clavel Tosco on 9/27/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

//
enum Team: Int {
    case Team1 = 1
    case Team2 = 2
    
    static let allValues = [Team1, Team2]
    
    func oppositeTeam() -> Team {
        switch self {
        case .Team1:
            return .Team2
        case .Team2:
            return .Team1
        }
    }
}

//
class TeamComponent: GKComponent {
    let team: Team
    
    init(team: Team) {
        self.team = team
        super.init()
    }
}