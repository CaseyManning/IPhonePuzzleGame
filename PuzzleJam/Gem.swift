//
//  Gem.swift
//  PuzzleJam
//
//  Created by Casey Manning on 7/1/16.
//  Copyright © 2016 Casey Manning. All rights reserved.
//

import Foundation
import SpriteKit

class Gem {
    
    var sprite = SKSpriteNode(imageNamed: "Gem Orange.png")
    var x = 0
    var y = 0
    
    init(x: Int, y: Int, color: String) {
        sprite = SKSpriteNode(imageNamed: "Gem \(color).png")
        sprite.position.x = CGFloat(x*GameScene.datileWidth + GameScene.daoffsetX)
        sprite.position.y = CGFloat(y*GameScene.datileHeight + GameScene.daoffsetY + 60)
        sprite.zPosition = CGFloat(y * -2 + 1)
        self.x = x
        self.y = y
    }
    
}