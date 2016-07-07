//
//  EnemyBackAndForth.swift
//  PuzzleJam
//
//  Created by Casey Manning on 7/1/16.
//  Copyright © 2016 Casey Manning. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyBlocker: Enemy {
    
    var back = false
    var mapX = 0
    var mapY = 0
    var mapZ = 0
    var direction = 0
    
    init(x: Int, y: Int) {
        super.init()
        sprite.position = CGPointMake(CGFloat(x*GameScene.datileWidth), CGFloat(y*GameScene.datileHeight))
        mapX = x
        mapY = y
        sprite.position.y += CGFloat(GameScene.datileHeight) + 15
        sprite.position.x += CGFloat(GameScene.datileWidth/2)
    }
    
    override func loadEnemy(x: Int, y: Int) {
        
    }
    
    override func move(playerPosition: Vector3, map: [[[Int]]]) {
        if mapX < playerPosition.x &&  map[mapY][mapZ][mapX + 1] == 0 {
            mapX += 1
            sprite.xScale = 1
            
        } else if mapX > playerPosition.x && map[mapY][mapZ][mapX-1] == 0 {
            mapX -= 1
            sprite.xScale = -1
            
        } else if mapY - 1 > playerPosition.y && map[mapY-1][mapZ][mapX] == 0 {
            mapY -= 1
        }
        
        sprite.position = CGPointMake(CGFloat(mapX*GameScene.datileWidth), CGFloat(mapY*GameScene.datileHeight))
        sprite.position.y += CGFloat(GameScene.datileHeight) + 15
        sprite.position.x += CGFloat(GameScene.datileWidth/2)
        print("Map x is \(mapX) and map y is \(mapY)")
        
    }
}