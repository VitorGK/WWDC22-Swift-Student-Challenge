//
//  File.swift
//  SwiftStudentChallenge2022
//
//  Created by Vitor Grechi Kuninari on 23/04/2022.
//

import SpriteKit

class MainMenuScene: SKScene {
    class func newScene() -> MainMenuScene {
        let newScene = MainMenuScene(size: .defaultSceneSize)
        newScene.scaleMode = .aspectFill
        return newScene
    }
    
    lazy var background: SKSpriteNode = {
        let sprite = SKSpriteNode(pixelImageNamed: "Background")
        
        sprite.zPosition = .zBackground
        sprite.position = CGPoint(x: size.width/2, y: size.height/2)
        
        return sprite
    }()
    lazy var logo: SKSpriteNode = {
        let sprite = SKSpriteNode(pixelImageNamed: "Logo")
        sprite.setScale(3)
        
        sprite.zPosition = .zHud
        sprite.position = CGPoint(x: size.width/2, y: 320)
        
        return sprite
    }()
    lazy var playButton: ButtonNode = {
        let button = ButtonNode(defaultTexture: "PlayButtonDefault", pressedTexture: "PlayButtonPressed") { [self] in
            view?.presentScene(GameScene.newScene())
        }
        
        button.position = CGPoint(x: size.width/2, y: 160)
        
        return button
    }()
    lazy var aboutButton: ButtonNode = {
        let button = ButtonNode(defaultTexture: "AboutButtonDefault", pressedTexture: "AboutButtonPressed") { [self] in
            view?.presentScene(AboutScene.newScene())
        }
        
        button.position = CGPoint(x: playButton.position.x, y: playButton.position.y-48)
        
        return button
    }()
    lazy var highscoreLabel: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: "HIGHSCORE: \(GameController.shared.highscore)",
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 32, weight: .regular),
                .foregroundColor: UIColor.white
            ]
        ))
        label.verticalAlignmentMode = .bottom
        label.setScale(1/4)
        
        label.zPosition = .zHud
        label.position = CGPoint(x: playButton.position.x, y: playButton.position.y+playButton.frame.height/2+16)
        
        return label
    }()
    
    func setUpScene() {
        view?.ignoresSiblingOrder = true
        
        addChild(background)
        addChild(logo)
        addChild(playButton)
        addChild(aboutButton)
        if GameController.shared.highscore > 0 {
            addChild(highscoreLabel)
        }
    }
    
    override func didMove(to view: SKView) {
        setUpScene()
    }
}
