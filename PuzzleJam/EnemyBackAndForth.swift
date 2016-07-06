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
    var mapX = 0
    var mapY = 0
    var mapZ = 0
    
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
    
    override func move(playerPosition: CGPoint, map: [[CGPoint]]) {
        if back {
            if map[mapX][mapY].y == map[mapX - 1][mapY].y {
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
            if map[mapX][mapY].y == map[mapX + 1][mapY].y {
                
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