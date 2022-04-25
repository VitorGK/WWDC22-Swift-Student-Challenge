//
//  File.swift
//  SwiftStudentChallenge2022
//
//  Created by Vitor Grechi Kuninari on 23/04/2022.
//

import SpriteKit

class PlanetNode: SKSpriteNode {
    let planetTextures: [SKTexture] = [
        SKTexture(pixelImageNamed: "Planet0"),
        SKTexture(pixelImageNamed: "Planet1"),
        SKTexture(pixelImageNamed: "Planet2"),
        SKTexture(pixelImageNamed: "Planet3"),
        SKTexture(pixelImageNamed: "Planet4"),
        SKTexture(pixelImageNamed: "Planet5"),
        SKTexture(pixelImageNamed: "Planet6"),
        SKTexture(pixelImageNamed: "Planet7"),
        SKTexture(pixelImageNamed: "Planet8"),
        SKTexture(pixelImageNamed: "Planet9"),
        SKTexture(pixelImageNamed: "Planet10"),
        SKTexture(pixelImageNamed: "Planet11")
    ]
    
    init() {
        let texture = planetTextures[0]
        super.init(texture: texture, color: .clear, size: texture.size())
        
        name = "Planet"
        
        physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        physicsBody?.categoryBitMask = .planetBitMask
        physicsBody?.collisionBitMask = .none
        physicsBody?.contactTestBitMask = .enemyBitMask
        physicsBody?.isDynamic = false
        
        zPosition = .zPlanet
        
        run(.repeatForever(.animate(with: planetTextures, timePerFrame: 1)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
