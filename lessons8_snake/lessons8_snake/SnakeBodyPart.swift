//
//  SnakeBodyPart.swift
//  lessons8_snake
//
//  Created by MICHAIL SHAKHVOROSTOV on 14.10.2021.
//

import UIKit
import SpriteKit


class SnakeBodyPart: SKShapeNode {
    
    let diametr = 10
    
    
    init(atPOint point: CGPoint) {
        super.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        fillColor = .green
        strokeColor = .green
        lineWidth = 10
        
        self.position = point
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(diametr), center: CGPoint(x: 5, y: 5))
        self.physicsBody?.isDynamic = true
        
        self.physicsBody?.categoryBitMask = CollisonCategries.Snake
        self.physicsBody?.contactTestBitMask = CollisonCategries.EdgeBody | CollisonCategries.Apple
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

