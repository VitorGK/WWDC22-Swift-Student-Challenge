//
//  File.swift
//  HEADS UP!!!
//
//  Created by Vitor Grechi Kuninari on 25/04/2022.
//

import SpriteKit

class ToggleNode: SKSpriteNode {
    var status: Bool
    let defaultTextureOn: SKTexture
    let pressedTextureOn: SKTexture
    let defaultTextureOff: SKTexture
    let pressedTextureOff: SKTexture
    let actionOn: () -> Void
    let actionOff: () -> Void
    
    init(status: Bool = true, defaultTextureOn: String, pressedTextureOn: String, defaultTextureOff: String, pressedTextureOff: String, actionOn: @escaping () -> Void, actionOff: @escaping () -> Void) {
        self.status = status
        self.defaultTextureOn = SKTexture(pixelImageNamed: defaultTextureOn)
        self.pressedTextureOn = SKTexture(pixelImageNamed: pressedTextureOn)
        self.defaultTextureOff = SKTexture(pixelImageNamed: defaultTextureOff)
        self.pressedTextureOff = SKTexture(pixelImageNamed: pressedTextureOff)
        self.actionOn = actionOn
        self.actionOff = actionOff
        
        if self.status {
            super.init(texture: self.defaultTextureOn, color: .clear, size: self.defaultTextureOn.size())
        } else {
            super.init(texture: self.defaultTextureOff, color: .clear, size: self.defaultTextureOff.size())
        }
        
        zPosition = .zHud
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if status {
            self.run(.setTexture(pressedTextureOn))
        } else {
            self.run(.setTexture(pressedTextureOff))
        }
        if !GameController.shared.isSfxMuted {
            self.run(.playSoundFileNamed("ButtonPressed.wav", waitForCompletion: false))
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if status {
            self.run(.setTexture(defaultTextureOn))
        } else {
            self.run(.setTexture(defaultTextureOff))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        status.toggle()
        if status {
            self.run(.setTexture(defaultTextureOn))
        } else {
            self.run(.setTexture(defaultTextureOff))
        }
        if !GameController.shared.isSfxMuted {
            self.run(.playSoundFileNamed("ButtonReleased.wav", waitForCompletion: false)) { [self] in
                if status {
                    actionOn()
                } else {
                    actionOff()
                }
            }
        } else {
            if status {
                actionOn()
            } else {
                actionOff()
            }
        }
    }
}
