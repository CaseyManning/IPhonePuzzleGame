//
//  swift
//  PuzzleJam
//
//  Created by Casey Manning on 6/29/16.
//  Copyright (c) 2016 Casey Manning. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var map: [[[Int]]] = []
    
    var level = -1
    
    var levels: [Level] = [Level]()
    static let daoffsetX = 50
    static let daoffsetY = 70
    static let datileWidth = 100
    static let datileHeight = 80

    let tileWidth = GameScene.datileWidth
    let tileHeight = GameScene.datileHeight

    var offsetx = 50
    var offsety = 70
    
    var goalLocations = [Vector3(x: 7, z: 6, y: 0), Vector3(x: 7, z: 6, y: 0), Vector3(x: 7, z: 6, y: 0)]
    var startPosititons = [Vector3(x: 3, z: 2, y: 0), Vector3(x: 4, z: 2, y: 0), Vector3(x: 5, z: 2, y: 0)]
    
    
    
    let height = 40
    var numGems = 0
    var levelDone = false
    
    var shadowLeft: SKSpriteNode = SKSpriteNode(imageNamed: "Shadow East.png")
    var shadowRight: SKSpriteNode = SKSpriteNode(imageNamed: "Shadow West.png")
    var shadowUp: SKSpriteNode = SKSpriteNode(imageNamed: "Shadow South.png")
    var shadowDown: SKSpriteNode = SKSpriteNode(imageNamed: "Shadow North.png")
    var shadowLeftBottom: SKSpriteNode = SKSpriteNode(imageNamed: "Shadow North East.png")
    var shadowRightBottom: SKSpriteNode = SKSpriteNode(imageNamed: "Shadow North West.png")
    var shadowTopRight: SKSpriteNode = SKSpriteNode(imageNamed: "Shadow South West.png")
    var shadowTopLeft: SKSpriteNode = SKSpriteNode(imageNamed: "Shadow South East.png")
    
    var player = SKSpriteNode(imageNamed: "Character1.png")
    let goal = SKSpriteNode(imageNamed: "Selector.png")
    var scroll = 0
    
    var text1: SKLabelNode!
    var text2: SKLabelNode!
    var numText: SKLabelNode!
    
    var playerX = 0
    var playerY = 0
    var playerZ = 0

    
    override func didMoveToView(view: SKView) {
        
        text1 = childNodeWithName("text1") as! SKLabelNode
        text2 = childNodeWithName("text2") as! SKLabelNode
        numText = childNodeWithName("numText") as! SKLabelNode

        loadLevels()
        nextLevel()
        print("Level is \(level)")
        print("Positioning player at: \(startPosititons[level])")
        for bug in levels[level].bugs {
            addChild(bug.sprite)
        }
        for gem in levels[level].gems {
            gem.sprite.zPosition = 100
            addChild(gem.sprite)
            gem.sprite.runAction(SKAction(named: "GemHovering")!)
        }
        
        
    }
    
    func C(x: Int, y: Int) -> CGPoint {
        return CGPoint(x: x, y: y)
    }
    
    
    //ERROR: If object is on a high up tile, will return wrong value
    func convertPointToGrid(point: CGPoint) -> CGPoint {
        return CGPointMake((point.x - CGFloat(offsetx))/CGFloat(tileWidth), (point.y - CGFloat(offsety))/CGFloat(tileHeight))
    }
    
    func loadLevels() {
        //X value is tile type. Y value is tile height
        
        /*let level1 = [[C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
                       [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
                       [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
                       [C(3, y: 0), C(3, y: 0), C(0, y: 1), C(0, y: 1), C(3, y: 0), C(0, y: 1), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
                       [C(3, y: 0), C(3, y: 0), C(0, y: 1), C(3, y: 0), C(3, y: 0), C(0, y: 1), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
                       [C(3, y: 0), C(3, y: 0), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(3, y: 0), C(3, y: 0)],
                       [C(3, y: 0), C(3, y: 0), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(3, y: 0), C(3, y: 0)],
                       [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(3, y: 0), C(3, y: 0)],
                       [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
                       [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
                       [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
                       [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
                       [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)]]
        
        let level2 = [[C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(0, y: 1), C(0, y: 1), C(3, y: 0), C(0, y: 1), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(0, y: 1), C(3, y: 0), C(3, y: 0), C(0, y: 1), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)]]
        
        let level3 = [[C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(0, y: 1), C(0, y: 1), C(3, y: 0), C(0, y: 1), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(0, y: 1), C(3, y: 0), C(3, y: 0), C(0, y: 1), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(0, y: 1), C(0, y: 1), C(0, y: 1), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(3, y:
                0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
            [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)]]*/
        
        var level1: [[[Int]]] = [[[]]]
        
                let d = [[0, 0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0, 0]]
        
        level1.append(d)
        
        
                let a = [[0, 0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 1, 1, 1, 1, 0, 0],
                         [0, 0, 1, 1, 1, 1, 1, 0, 0],
                         [0, 0, 1, 1, 1, 1, 1, 0, 0],
                         [0, 0, 1, 1, 1, 1, 1, 0, 0],
                         [0, 0, 1, 1, 1, 1, 1, 0, 0],
                         [0, 0, 1, 0, 0, 0, 1, 0, 0],
                         [0, 0, 1, 1, 1, 1, 1, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0, 0]]
        level1.append(a)
        
                let f = [[4, 4, 4, 4, 4, 4, 4, 4, 4],
                         [4, 4, 4, 4, 4, 4, 4, 4, 4],
                         [4, 4, 4, 1, 1, 1, 1, 4, 4],
                         [4, 4, 1, 1, 1, 1, 1, 4, 4],
                         [4, 4, 1, 1, 1, 1, 1, 4, 4],
                         [4, 4, 1, 1, 1, 1, 1, 4, 4],
                         [4, 4, 1, 1, 1, 1, 1, 4, 4],
                         [4, 4, 1, 4, 4, 4, 1, 4, 4],
                         [4, 4, 1, 1, 1, 1, 1, 4, 4],
                         [4, 4, 4, 4, 4, 4, 4, 4, 4],
                         [4, 4, 4, 4, 4, 4, 4, 4, 4],
                         [4, 4, 4, 4, 4, 4, 4, 4, 4],
                         [4, 4, 4, 4, 4, 4, 4, 4, 4]]
        
        level1.append(f)

        
        levels.append(Level(map: level1, x: 3, y: 2, bugs: [EnemyBackAndForth(x: 4, y: 5)], gems: [Gem(x: 4, y: 5, color: "OrangeSmall")]))
        levels.append(Level(map: level1, x: 3, y: 2, bugs: [EnemyBlocker(x: 4, y: 5)], gems: [Gem(x: 4, y: 5, color: "OrangeSmall")]))
        levels.append(Level(map: level1, x: 3, y: 2, bugs: [EnemyBackAndForth(x: 4, y: 5)], gems: [Gem(x: 4, y: 5, color: "OrangeSmall")]))
    }
    
    func canMove(move: Vector3) -> Bool {
        
        return map[move.y][move.x][move.z] == 0
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if levelDone { return }
       /* Called when a touch begins */
        for touch in touches {
           let diffx = touch.locationInNode(self).x - player.position.x
           let diffy = touch.locationInNode(self).y - player.position.y
            
            if(abs(diffx) > abs(diffy)) {
                //moving on the x-axis
                if(diffx > 0) {
                    if(canMove(Vector3( x: playerX + 1, z: playerZ, y: playerY))) {
                    player.position.x += CGFloat(tileWidth)
                    }
                } else {
                    if(canMove(Vector3(x: playerX - 1, z: playerZ, y: playerY))) {
                     player.position.x -= CGFloat(tileWidth)
                    }
                }
            } else {
                //moving on the z-axis
                if(diffy > 0) {
                    if(canMove(Vector3(x: playerX, z: playerZ + 1, y: playerY))) {
                        player.position.y += CGFloat(tileHeight)
                    }
                } else {
                    if(canMove(Vector3(x: playerX, z: playerZ - 1, y: playerY))) {
                        player.position.y -= CGFloat(tileHeight)
                    }
                }
            }
        
        }
        player.zPosition = convertPointToGrid(player.position).y * 2 + 1.5
        checkForBugCollisions()
        for bug in levels[level].bugs {
            bug.move(Vector3(x: playerX, z: playerZ, y: playerY), map: map)
        }
        for gem in levels[level].gems {
            if Int(convertPointToGrid(player.position).x) == gem.x && Int(convertPointToGrid(player.position).y) == gem.y && gem.sprite.parent == self {
                // You gots the gem!
                gem.sprite.removeFromParent()
                numGems += 1
                
            }
        }
  
    }
    
    func checkForBugCollisions() {
        if levelDone { return }
        
        //This line gives fatal error: Index out of range when I die and the game restarts
        for bug in levels[level].bugs {
            if Int(convertPointToGrid(player.position).x) == Int(convertPointToGrid(bug.sprite.position).x) && Int(convertPointToGrid(player.position).y) == Int(convertPointToGrid(bug.sprite.position).y) {
                //Ya dead! 
                restartLevel()
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
       checkForBugCollisions()
       // :(
        //print("Does (\(Int(convertPointToGrid(player.position).x)), \(Int(convertPointToGrid(player.position).y))) equal \(goalLocation)")
        if playerX == Int(goalLocations[level].x) && playerZ == Int(goalLocations[level].y) && goal.parent == self && playerY == goalLocations[level].y {
            print("You have completeted the level with sufficient bug-avoiding aptitude to continue. Yay.")
            goal.removeFromParent()
            levelDone = true
            text1.zPosition = 100
            text2.zPosition = 100
            numText.zPosition = 100
            numText.text = String(numGems)
            nextLevel()
            
             addChild(text1)
             addChild(text2)
             addChild(numText)

        }
       
        if levelDone {
            scroll += 5
            if scroll > /*380000*/(map[0].count/2)*tileWidth {
                levelDone = false
                //level += 1
                for i in 1...map.count/2 {
                    map[i].removeFirst()
                    
                }
                
                player.position = CGPointMake(CGFloat(startPosititons[level].x*tileWidth + offsetx), CGFloat(startPosititons[level].y*tileHeight + offsety + height))
                
                let skView = self.view as SKView!
                
                /* Load Game scene */
                let scene = GameScene(fileNamed:"GameScene") as GameScene!
                
                /* Ensure correct aspect mode */
                scene.scaleMode = .AspectFill
                
                scene.level = self.level - 1
                /* Start game scene */
                skView.presentScene(scene)
                

                text1.removeFromParent()
                text2.removeFromParent()
                numText.removeFromParent()
            }
            for node in children {
                node.position.x -= 5
                
            }
        }
       
    }//
    
    func getTileSpriteFromNum(num: Int) -> SKSpriteNode {
        let s = SKSpriteNode(imageNamed: "\(num).png")
        return s
    }
    
    func restartLevel() {
        let skView = self.view as SKView!
        
        /* Load Game scene */
        let scene = GameScene(fileNamed:"GameScene") as GameScene!
        
        /* Ensure correct aspect mode */
        scene.scaleMode = .AspectFill
        
        /* Start game scene */
        skView.presentScene(scene)
        
        scene.level = self.level - 1
    }

    
    func nextLevel() {
        level += 1
        //Error: Will extend map upwards, not to the side
        
        for list in levels[level].map {
            map.append(list)
        }
       
        removeAllChildren()
        for(i, foo) in map.enumerate() {
            for(j, bar) in foo.enumerate() {
                for(k, foobar) in bar.enumerate() {
                     print("I is \(i), j is \(j), and k is \(k)")
                    let sprite = getTileSpriteFromNum(Int(foobar))
                    sprite.position = CGPoint(x: j*tileWidth + offsetx, y: k*tileHeight + i*height + offsety)
                    var a = -i*1000
                    var b = -k*10
                    sprite.zPosition = CGFloat(a + b + j)
                    addChild(sprite)
                }
            }
        }
        //drawShadows()
        player.position = CGPointMake(CGFloat(startPosititons[level].x*tileWidth + offsetx), CGFloat(startPosititons[level].y*tileHeight + offsety))
        player.zPosition = 100
        if level == 1 {
            
        }
        addChild(player)
        
        goal.position = CGPointMake(CGFloat(goalLocations[level].x*tileWidth + offsetx), CGFloat(goalLocations[level].z*tileHeight + offsety + tileHeight/2)/* + CGFloat(map[Int(goalLocation.x)][Int(goalLocation.y)]*height) \\*/)
        
        
        goal.zPosition = 30
        addChild(goal)
    }
    
    
     
    /*func drawShadows() {
        for(i, foo) in map.enumerate() {
            for(j, _) in foo.enumerate() {
                
                if map[i][j].y != 0 {
                    
                    
                    if map[i-1][j].y < map[i][j].y {
                        createShadow(shadowLeft.copy() as! SKSpriteNode, i: i-1, j: j, iOffset: -1, jOffset: 0)
                       
                    }
                    if map[i+1][j].y < map[i][j].y {
                        createShadow(shadowRight.copy() as! SKSpriteNode, i: i+1, j: j, iOffset: 1, jOffset: 0)
                        
                    }
                    if map[i][j-1].y < map[i][j].y {
                     createShadow(shadowDown.copy() as! SKSpriteNode, i: i, j: j-1, iOffset: 0, jOffset: -1)
                        
                    }
                    if map[i][j+1].y < map[i][j].y {
                     createShadow(shadowUp.copy() as! SKSpriteNode, i: i, j: j+1, iOffset: 0, jOffset: 1)
                    }
                    
                    /*if map[i+1][j+1].y < map[i][j].y {
                        createShadow(shadowTopRight.copy() as! SKSpriteNode, i: i, j: j+1, iOffset: 1, jOffset: 1)
                    }
                    
                    if map[i-1][j+1].y < map[i][j].y {
                        createShadow(shadowTopLeft.copy() as! SKSpriteNode, i: i, j: j+1, iOffset: 0, jOffset: 1)
                    }
                    
                    if map[i-1][j-1].y < map[i][j].y {
                        createShadow(shadowLeftBottom.copy() as! SKSpriteNode, i: i, j: j+1, iOffset: -1, jOffset: -1)
                    }
                    
                    if map[i+1][j-1].y < map[i][j].y {
                        createShadow(shadowRightBottom.copy() as! SKSpriteNode, i: i, j: j+1, iOffset: 1, jOffset: -1)
                    }*/
                }
            }
        }
    }
    
    func createShadow(shadow: SKSpriteNode, i: Int, j: Int, iOffset: Int, jOffset: Int) {
        print("Adding shadow at position \(i+iOffset), \(j+jOffset). yay...")
        shadow.position = CGPoint(x: i*tileWidth + offsetx, y: j*tileHeight + Int(map[i+iOffset][j+jOffset].y)*height + offsety)
        shadow.zPosition = 100
        
        addChild(shadow)
    }*/
}
