//
//  Enemy.swift
//  PuzzleJam
//
//  Created by Casey Manning on 6/29/16.
//  Copyright © 2016 Casey Manning. All rights reserved.
//

import Foundation
import SpriteKit

enum AI {
    case none, BackAndForth, Follow, Wall
}

class Enemy{

    var sprite = SKSpriteNode(imageNamed: "Enemy Bug.png")
    
    
    func loadEnemy(x: Int, y: Int) {
        
    }
    
    func move(playerPosition: Vector3, map: [[[Int]]]) {
        
    }
    
}