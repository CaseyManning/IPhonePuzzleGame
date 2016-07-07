//
//  Level.swift
//  PuzzleJam
//
//  Created by Casey Manning on 7/6/16.
//  Copyright © 2016 Casey Manning. All rights reserved.
//

import Foundation
import SpriteKit

class Level {
    
    var map: [[[Int]]]
    var startX: Int
    var startY: Int
    var bugs: [Enemy]
    var gems: [Gem]
    
    init(map: [[[Int]]], x: Int, y: Int, bugs: [Enemy], gems: [Gem]) {
        self.map = map
        startX = x
        startY = y
        self.bugs = bugs
        self.gems = gems
    }
}
