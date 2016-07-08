//
//  EnemyBackAndForth.swift
//  PuzzleJam
//
//  Created by Casey Manning on 7/1/16.
//  Copyright © 2016 Casey Manning. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyBackAndForth: Enemy {
    
    var back = false
    var mapX = 5
    var mapY = 1
    var mapZ = 5
    
    init(location: Vector3) {
        super.init()
        sprite.position = CGPointMake(CGFloat(location.x*GameScene.datileWidth), CGFloat(location.z*GameScene.datileHeight))
        mapX = location.x
        mapY = location.y
        mapZ = location.z
        sprite.position.y += CGFloat(GameScene.datileHeight) + 15
        sprite.position.x += CGFloat(GameScene.datileWidth/2)
    }
    
    override func loadEnemy(x: Int, y: Int) {
        
    }
    
    override func move(playerPosition: Vector3, map: [[[Int]]]) {
        if back {
            if map[mapY][mapZ][mapX - 1] == 0 {
                mapX -= 1
                sprite.position.x -= CGFloat(GameScene.datileWidth)
                return
            } else {
                
                back = !back
                sprite.xScale = -sprite.xScale
                move(playerPosition, map: map)
                return
            }
        } else {
            print(mapX)
            print(mapY)
            print(mapZ)
            if map[mapY][mapZ][mapX + 1] == 0 {
                
                mapX += 1
                sprite.position.x += CGFloat(GameScene.datileWidth)
                return
            } else {
                
                back = !back
                sprite.xScale = -sprite.xScale
                move(playerPosition, map: map)
                return
            }
        }
    }
}