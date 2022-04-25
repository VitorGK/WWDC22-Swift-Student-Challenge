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
    let sounds: [String]
    
    init() {
        let random = Int.random(in: 0..<textures.count)
        let texture = textures[random]
        
        if random == 0 {
            sounds = [
                "EnemySaucer0.wav",
                "EnemySaucer1.wav",
            ]
        } else {
            sounds = [
                "EnemyAsteroid0.wav",
                "EnemyAsteroid1.wav",
                "EnemyAsteroid2.wav",
                "EnemyAsteroid3.wav",
            ]
        }
        
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
        let explosion = SKSpriteNode(pixelImageNamed: "Explosion" + String(Int.random(in: 0...3)))
        let angles: [CGFloat] = [0, 90, 180, 270]
        explosion.zRotation = angles.randomElement()! * CGFloat.pi / 180
        explosion.zPosition = zPosition + 1
        addChild(explosion)
        removeAllActions()
        if !GameController.shared.isSfxMuted {
            self.run(.playSoundFileNamed(sounds.randomElement()!, waitForCompletion: false))
        }
        self.run(.fadeOut(withDuration: 0.5)) { [self] in
            removeFromParent()
        }
    }
}
