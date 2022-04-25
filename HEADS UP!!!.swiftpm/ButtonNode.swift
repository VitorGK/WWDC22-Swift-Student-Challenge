//
//  File.swift
//  SwiftStudentChallenge2022
//
//  Created by Vitor Grechi Kuninari on 23/04/2022.
//

import SpriteKit

class ButtonNode: SKSpriteNode {
    let defaultTexture: SKTexture
    let pressedTexture: SKTexture
    let action: () -> Void
    
    init(defaultTexture: String, pressedTexture: String, action: @escaping () -> Void) {
        self.defaultTexture = SKTexture(pixelImageNamed: defaultTexture)
        self.pressedTexture = SKTexture(pixelImageNamed: pressedTexture)
        self.action = action
        
        super.init(texture: self.defaultTexture, color: .clear, size: self.defaultTexture.size())
        
        zPosition = .zHud
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.run(.setTexture(pressedTexture))
        if !GameController.shared.isSfxMuted {
            self.run(.playSoundFileNamed("ButtonPressed.wav", waitForCompletion: false))
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.run(.setTexture(defaultTexture))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.run(.setTexture(defaultTexture))
        if !GameController.shared.isSfxMuted {
            self.run(.playSoundFileNamed("ButtonReleased.wav", waitForCompletion: false)) { [self] in
                action()
            }
        } else {
            action()
        }
    }
}
