//
//  swift
//  PuzzleJam
//
//  Created by Casey Manning on 6/29/16.
//  Copyright (c) 2016 Casey Manning. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var map: [[CGPoint]] = []
    
    var level = -1
    
    var levels: [[[CGPoint]]] = [[[CGPoint]]]()
    static let daoffsetX = 50
    static let daoffsetY = 70
    static let datileWidth = 100
    static let datileHeight = 80

    let tileWidth = GameScene.datileWidth
    let tileHeight = GameScene.datileHeight

    var offsetx = 50
    var offsety = 70
    
    var goalLocations = [CGPointMake(7, 6), CGPointMake(7, 6), CGPointMake(7, 6)]
    var startPosititons = [CGPointMake(3, 2), CGPointMake(4, 2), CGPointMake(5, 2)]
    
    let height = 40
    var bugs: [[Enemy]] = [[EnemyBackAndForth(x: 4, y: 5)], [EnemyBlocker(x: 4, y: 5)], [EnemyBackAndForth(x: 4, y: 5)]]
    var gems: [Gem] = [Gem(x: 4, y: 5, color: "OrangeSmall")]
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

    
    override func didMoveToView(view: SKView) {
        
        text1 = childNodeWithName("text1") as! SKLabelNode
        text2 = childNodeWithName("text2") as! SKLabelNode
        numText = childNodeWithName("numText") as! SKLabelNode

        loadLevels()
        nextLevel()
        print("Level is \(level)")
        print("Positioning player at: \(startPosititons[level])")
        for bug in bugs[level] {
            addChild(bug.sprite)
        }
        for gem in gems {
            gem.sprite.zPosition = 100
            addChild(gem.sprite)
            gem.sprite.runAction(SKAction(named: "GemHovering")!)
        }
        
        

        let playerHeight = map[Int(convertPointToGrid(player.position).x)][Int(convertPointToGrid(player.position).y)].y
        player.position.y += playerHeight*CGFloat(height)
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
        
        levels.append([[C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
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
                       [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)]])
        
        levels.append([[C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
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
            [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)]])
        
        levels.append([[C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)],
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
            [C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0), C(3, y: 0)]])
    }
    
    func canMove(position: CGPoint, move: CGPoint) -> Bool {
        let a = Int(convertPointToGrid(move).x)
        let b = Int(convertPointToGrid(move).y)
        let c = Int(convertPointToGrid(position).x)
        let d = Int(convertPointToGrid(position).y)
        
        print("Moving from (\(c), \(d)) to (\(a), \(b))")
        
        print("We are moving to height of \(map[c][d].y) from height of \(map[a][b].y)")
        return map[a][b].y == map[c][d].y
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if levelDone { return }
       /* Called when a touch begins */
        let playerHeight = map[Int(convertPointToGrid(player.position).x)][Int(convertPointToGrid(player.position).y)].y
        for touch in touches {
           let diffx = touch.locationInNode(self).x - player.position.x
           let diffy = touch.locationInNode(self).y - player.position.y
            
            if(abs(diffx) > abs(diffy)) {
                //moving on the x-axis
                if(diffx > 0) {
                    if(canMove(player.position, move: CGPointMake(player.position.x + CGFloat(tileWidth), player.position.y))) {
                    player.position.x += CGFloat(tileWidth)
                    }
                } else {
                        if(canMove(player.position, move: CGPointMake(player.position.x - CGFloat(tileWidth), player.position.y))) {
                     player.position.x -= CGFloat(tileWidth)
                    }
                }
            } else {
                //moving on the y-axis
                if(diffy > 0) {
                    if(canMove(player.position, move: CGPointMake(player.position.x, player.position.y + CGFloat(tileHeight)))) {
                        player.position.y += CGFloat(tileHeight)
                    }
                } else {
                    if(canMove(player.position, move: CGPointMake(player.position.x, player.position.y - CGFloat(tileHeight)))) {
                        player.position.y -= CGFloat(tileHeight)
                    }
                }
            }
        
        }
        let newPlayerHeight = map[Int(convertPointToGrid(player.position).x)][Int(convertPointToGrid(player.position).y)].y
        if newPlayerHeight > playerHeight {
            player.position.y += CGFloat(height)
        } else if newPlayerHeight < playerHeight {
            player.position.y -= CGFloat(height)
        }
        player.zPosition = convertPointToGrid(player.position).y * -2 + 1.5
        checkForBugCollisions()
        for bug in bugs[level] {
            bug.move(convertPointToGrid(player.position), map: map)
        }
        for gem in gems {
            if Int(convertPointToGrid(player.position).x) == gem.x && Int(convertPointToGrid(player.position).y) == gem.y {
                // You gots the gem!
                gem.sprite.removeFromParent()
                numGems += 1
                
            }
        }
  
    }
    
    func checkForBugCollisions() {
        if levelDone { return }
        
        for bug in bugs[level] {
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
        if Int(convertPointToGrid(player.position).x) == Int(goalLocations[level].x) && Int(convertPointToGrid(player.position).y) == Int(goalLocations[level].y) && goal.parent == self {
            print("You have completeted the level with sufficient bug-avoiding aptitude to continue. Yay.")
            goal.removeFromParent()
            levelDone = true
            text1.zPosition = 100
            text2.zPosition = 100
            numText.zPosition = 100
            numText.text = String(numGems)
            nextLevel()
            player.position = CGPointMake(startPosititons[level].x*CGFloat(tileWidth) + CGFloat(offsetx + (map.count/2)*tileWidth*5), startPosititons[level].y*CGFloat(tileHeight) + CGFloat(offsety + height
                ))
            
             addChild(text1)
             addChild(text2)
             addChild(numText)

        }
       
        if levelDone {
            scroll += 5
            if scroll > /*380000*/(map.count/2)*tileWidth {
                levelDone = false
                //level += 1
                for _ in 1...map.count/2 {
                    map.removeFirst()
                    player.position = CGPointMake(startPosititons[level].x*CGFloat(tileWidth) + CGFloat(offsetx), startPosititons[level].y*CGFloat(tileHeight) + CGFloat(offsety + height
                        ))
                }
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
        print("DOTATOP \(level)")
        for list in levels[level] {
            map.append(list)
        }
        removeAllChildren()
        for(i, foo) in map.enumerate() {
            for(j, bar) in foo.enumerate() {
                let sprite = getTileSpriteFromNum(Int(bar.x))
                sprite.position = CGPoint(x: i*tileWidth + offsetx, y: j*tileHeight + Int(bar.y)*height + offsety)
                sprite.zPosition = CGFloat(-j*2)
                addChild(sprite)
            }
        }
        drawShadows()
        player.position = CGPointMake(startPosititons[level].x*CGFloat(tileWidth) + CGFloat(offsetx), startPosititons[level].y*CGFloat(tileHeight) + CGFloat(offsety))
        player.zPosition = 100
        if level == 1 {
            
        }
        addChild(player)
        
        let f = CGFloat((map[Int(goalLocations[level].x)][Int(goalLocations[level].y)].y)*CGFloat(height))
        goal.position = CGPointMake(goalLocations[level].x*CGFloat(tileWidth) + CGFloat(offsetx), (goalLocations[level].y)*CGFloat(tileHeight) + CGFloat(offsety) + CGFloat(tileHeight/2)/* + CGFloat(map[Int(goalLocation.x)][Int(goalLocation.y)]*height) \\*/)
        goal.position.y += f
        
        
        goal.zPosition = 30
        addChild(goal)
    }
    
    
     
    func drawShadows() {
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
    }
}
