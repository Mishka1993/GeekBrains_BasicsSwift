//
//  SnakeHead.swift
//  lessons8_snake
//
//  Created by MICHAIL SHAKHVOROSTOV on 14.10.2021.
//

import UIKit

class SnakeHead: SnakeBodyPart {
    override init(atPOint point: CGPoint) {
        super.init(atPOint: point)
        self.physicsBody?.categoryBitMask = CollisonCategries.SnakeHead
        self.physicsBody?.contactTestBitMask = CollisonCategries.EdgeBody | CollisonCategries.Apple | CollisonCategries.Snake
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
