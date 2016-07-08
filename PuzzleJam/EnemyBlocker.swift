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
    
    override func move(playerPosition: CGPoint, map: [[CGPoint]]) {
        if mapX < Int(playerPosition.x) && map[mapX][mapY].y == map[mapX+1][mapY].y {
            mapX += 1
            sprite.xScale = 1
            
        } else if mapX > Int(playerPosition.x)  && map[mapX][mapY].y == map[mapX-1][mapY].y {
            mapX -= 1
            sprite.xScale = -1
            
        } else if mapY - 1 > Int(playerPosition.y)  && map[mapX][mapY].y == map[mapX][mapY-1].y{
            mapY -= 1
        }
        
        sprite.position = CGPointMake(CGFloat(mapX*GameScene.datileWidth), CGFloat(mapY*GameScene.datileHeight))
        sprite.position.y += CGFloat(GameScene.datileHeight) + 15
        sprite.position.x += CGFloat(GameScene.datileWidth/2)
        print("Bug y is \(map[mapX][mapY].y)")
        print("Map x is \(mapX) and map y is \(mapY)")
        
    }
}