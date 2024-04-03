//
//  GameScene.swift
//  Angry
//
//  Created by Wiktor Witkowski on 31/01/2024.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
        var bottle = SKSpriteNode()
        var trash1 = SKSpriteNode()
        var trash2 = SKSpriteNode()
        var trash3 = SKSpriteNode()
        var trash4 = SKSpriteNode()
        var trash5 = SKSpriteNode()
    
        var gameStarted = false
    
        var score = 0
        var scoreLabel = SKLabelNode()
    
        var orginalPosition : CGPoint?
    
    enum Collider : UInt32 {
        case Bottle = 1
        case Trash = 2
        case Ground = 4
        case Man = 8
        
    }
        
    override func didMove(to view: SKView) {
        
        //Physics Body
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFit
        self.physicsWorld.contactDelegate = self
        
        
        //Bottle
        let bottleTexture = SKTexture(imageNamed: "pt4")
        
        bottle = childNode(withName: "bottle") as! SKSpriteNode
        bottle.physicsBody = SKPhysicsBody(circleOfRadius: bottleTexture.size().height / 10)
        bottle.physicsBody?.affectedByGravity = false
        bottle.physicsBody?.isDynamic = true
        bottle.physicsBody?.mass = 0.1
        orginalPosition = bottle.position
        
        bottle.physicsBody?.contactTestBitMask = Collider.Bottle.rawValue
        bottle.physicsBody?.categoryBitMask = Collider.Bottle.rawValue
        bottle.physicsBody?.collisionBitMask = Collider.Trash.rawValue
        
        //Trash
        
        let trashTexture = SKTexture(imageNamed: "trash")
        let size = CGSize(width: trashTexture.size().width / 6, height: trashTexture.size().height / 6)
        
        trash1 = childNode(withName: "trash1") as! SKSpriteNode
        trash1.physicsBody = SKPhysicsBody(rectangleOf: size)
        trash1.physicsBody?.isDynamic = true
        trash1.physicsBody?.affectedByGravity = true
        trash1.physicsBody?.allowsRotation = true
        trash1.physicsBody?.mass = 0.4
        
        trash1.physicsBody?.collisionBitMask = Collider.Bottle.rawValue
        
        trash2 = childNode(withName: "trash2") as! SKSpriteNode
        trash2.physicsBody = SKPhysicsBody(rectangleOf: size)
        trash2.physicsBody?.isDynamic = true
        trash2.physicsBody?.affectedByGravity = true
        trash2.physicsBody?.allowsRotation = true
        trash2.physicsBody?.mass = 0.4
        
        trash2.physicsBody?.collisionBitMask = Collider.Bottle.rawValue
        
        trash3 = childNode(withName: "trash3") as! SKSpriteNode
        trash3.physicsBody = SKPhysicsBody(rectangleOf: size)
        trash3.physicsBody?.isDynamic = true
        trash3.physicsBody?.affectedByGravity = true
        trash3.physicsBody?.allowsRotation = true
        trash3.physicsBody?.mass = 0.4
        
        trash3.physicsBody?.collisionBitMask = Collider.Bottle.rawValue
        
        trash4 = childNode(withName: "trash4") as! SKSpriteNode
        trash4.physicsBody = SKPhysicsBody(rectangleOf: size)
        trash4.physicsBody?.isDynamic = true
        trash4.physicsBody?.affectedByGravity = true
        trash4.physicsBody?.allowsRotation = true
        trash4.physicsBody?.mass = 0.4
        
        trash4.physicsBody?.collisionBitMask = Collider.Bottle.rawValue
        
        trash5 = childNode(withName: "trash5") as! SKSpriteNode
        trash5.physicsBody = SKPhysicsBody(rectangleOf: size)
        trash5.physicsBody?.isDynamic = true
        trash5.physicsBody?.affectedByGravity = true
        trash5.physicsBody?.allowsRotation = true
        trash5.physicsBody?.mass = 0.4
        
        trash5.physicsBody?.collisionBitMask = Collider.Bottle.rawValue
        
        // Score Label
        
        scoreLabel.fontName = "Times New Roman"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.fontColor = .black
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
        
        
        
        
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.collisionBitMask == Collider.Bottle.rawValue || contact.bodyB.collisionBitMask == Collider.Bottle.rawValue {
            
            score += 1
            scoreLabel.text = String(score)
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        bottle.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 100))
//        bottle.physicsBody?.affectedByGravity = true
        
        if gameStarted == false {
            
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bottle {
                                bottle.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
        
        
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
            
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bottle {
                                bottle.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
            
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bottle {
                                
                                let dx = -(touchLocation.x - orginalPosition!.x)
                                let dy = -(touchLocation.y - orginalPosition!.y)
                                
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bottle.physicsBody?.applyImpulse(impulse)
                                bottle.physicsBody?.affectedByGravity = true
                                
                                gameStarted = true
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        if let bottlePhysicsBody = bottle.physicsBody {
            if bottlePhysicsBody.velocity.dx <= 0.1 && bottlePhysicsBody.velocity.dy <= 0.1 && bottlePhysicsBody.angularVelocity <= 0.1 && gameStarted == true {
                
                bottlePhysicsBody.affectedByGravity = false
                bottlePhysicsBody.velocity = CGVector(dx: 0, dy: 0)
                bottlePhysicsBody.angularVelocity = 0
                bottle.zPosition = 1
                bottle.position = orginalPosition!
                gameStarted = false
            }
        }
        
    }
    
}
