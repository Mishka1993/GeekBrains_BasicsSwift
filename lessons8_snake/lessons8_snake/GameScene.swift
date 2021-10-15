//
//  GameScene.swift
//  lessons8_snake
//
//  Created by MICHAIL SHAKHVOROSTOV on 14.10.2021.
//

import SpriteKit
import GameplayKit

struct CollisonCategries {
    static let Snake: UInt32 = 0x1 << 0 //0001 2
    static let SnakeHead: UInt32 = 0x1 << 1 //0010 4 >> / 2 = 2
    static let Apple: UInt32 = 0x1 << 2 // 8
    static let EdgeBody: UInt32 = 0x1 << 3 // 16
}


class GameScene: SKScene {
    
    var snake: Snake?
    var score: Int = 0
    var scoreLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {

        backgroundColor = SKColor.black
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        
        view.showsPhysics = true
        
        let counterClockWiseButton = SKShapeNode()
        counterClockWiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockWiseButton.position = CGPoint(x: view.scene!.frame.minX + 30, y: view.scene!.frame.minY + 30)
        counterClockWiseButton.fillColor = .purple
        counterClockWiseButton.strokeColor = .purple
        counterClockWiseButton.lineWidth = 10
        
        counterClockWiseButton.name = "counterClockWiseButton"
        self.addChild(counterClockWiseButton)
        
        
        let clockWiseButton = SKShapeNode()
        clockWiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockWiseButton.position = CGPoint(x: view.scene!.frame.maxX - 60, y: view.scene!.frame.minY + 30)
        clockWiseButton.fillColor = .purple
        clockWiseButton.strokeColor = .purple
        clockWiseButton.lineWidth = 10
        clockWiseButton.name = "clockWiseButton"
        self.addChild(clockWiseButton)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Total Score: \(score)"
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: size.width/2, y: size.height/1.5)
        self.addChild(scoreLabel)
        
        createApple()
        
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
        
        self.physicsWorld.contactDelegate = self
        
        self.physicsBody?.categoryBitMask = CollisonCategries.EdgeBody
        self.physicsBody?.collisionBitMask = CollisonCategries.Snake | CollisonCategries.SnakeHead
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode, touchNode.name == "counterClockWiseButton" || touchNode.name == "clockWiseButton" else {
                return
            }
            
            touchNode.fillColor = .systemBlue
            
            if touchNode.name == "counterClockWiseButton" {
                snake!.moveCOunterClockwise()
            } else if touchNode.name == "clockWiseButton" {
                snake!.moveClockwise()
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode, touchNode.name == "counterClockWiseButton" || touchNode.name == "clockWiseButton" else {
                return
            }
            
            touchNode.fillColor = .purple
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
      
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        snake?.move()
    }
    
    
    func createApple() {
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX - 5)))
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY - 5)))
        
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        self.addChild(apple)
    }
}


extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask //8
        
        let collisionObject = bodyes - CollisonCategries.SnakeHead // 8 - 6 = 2
        
        switch collisionObject {
        case CollisonCategries.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            
            snake?.addBodyPart()
            apple?.removeFromParent()
            score += 1
            scoreLabel.text = "Total Score: \(score)"
            createApple()
            
        case CollisonCategries.EdgeBody:
            let scene = GameScene(size: (view?.bounds.size)!)

            let skView = view!

            skView.showsFPS = true
            skView.showsNodeCount = true

            scene.scaleMode = .resizeFill

            skView.presentScene(scene)
            
        default:
            break
        }
        
    }
}
