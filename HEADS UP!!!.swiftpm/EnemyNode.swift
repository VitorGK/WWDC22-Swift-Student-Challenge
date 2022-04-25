//
//  File.swift
//  SwiftStudentChallenge2022
//
//  Created by Vitor Grechi Kuninari on 23/04/2022.
//

import SpriteKit

class EnemyNode: SKSpriteNode {
    let textures = [
        SKTexture(pixelImageNamed: "Enemy0"),
        SKTexture(pixelImageNamed: "Enemy1"),
        SKTexture(pixelImageNamed: "Enemy2"),
        SKTexture(pixelImageNamed: "Enemy3"),
        SKTexture(pixelImageNamed: "Enemy4"),
        SKTexture(pixelImageNamed: "Enemy5"),
    ]
    
    init() {
        let texture = textures.randomElement()!
        super.init(texture: texture, color: .clear, size: texture.size())
        
        name = "Enemy"
        
        physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        physicsBody?.categoryBitMask = .enemyBitMask
        physicsBody?.collisionBitMask = .planetBitMask
        physicsBody?.contactTestBitMask = .none
        
        zPosition = .zEnemy
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isUserInteractionEnabled = false
        zPosition = zPosition - 2
        GameController.shared.increaseScore()
        let explosion = SKSpriteNode(pixelImageNamed: "Explosion" + String(Int.random(in: 0...2)))
        let angles: [CGFloat] = [0, 90, 180, 270]
        explosion.zRotation = angles.randomElement()! * CGFloat.pi / 180
        explosion.zPosition = zPosition + 1
        addChild(explosion)
        removeAllActions()
        self.run(.fadeOut(withDuration: 0.5)) { [self] in
            removeFromParent()
        }
    }
}
