//
//  File.swift
//  SwiftStudentChallenge2022
//
//  Created by Vitor Grechi Kuninari on 23/04/2022.
//

import SpriteKit

class GameOverScene: SKScene {
    class func newScene() -> GameOverScene {
        let newScene = GameOverScene(size: .defaultSceneSize)
        newScene.scaleMode = .aspectFill
        return newScene
    }
    
    lazy var background: SKSpriteNode = {
        let sprite = SKSpriteNode(pixelImageNamed: "Background")
        
        sprite.zPosition = .zBackground
        sprite.position = CGPoint(x: size.width/2, y: size.height/2)
        
        return sprite
    }()
    lazy var gameOverLabel0: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: "YOU HAVE DESTROYED",
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 64, weight: .regular),
                .foregroundColor: UIColor.white
            ])
        )
        label.verticalAlignmentMode = .center
        label.setScale(1/4)
        
        label.position = CGPoint(x: size.width/2, y: 380)
        
        return label
    }()
    lazy var gameOverLabel1: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: "SPACE THREATS",
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 64, weight: .regular),
                .foregroundColor: UIColor.white
            ])
        )
        label.verticalAlignmentMode = .center
        label.setScale(1/4)
        
        label.position = CGPoint(x: size.width/2, y: 260)
        
        return label
    }()
    lazy var scoreLabel: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: String(GameController.shared.currentScore),
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 256, weight: .bold),
                .foregroundColor: UIColor.white
            ])
        )
        label.verticalAlignmentMode = .center
        label.setScale(1/4)
        
        label.position = CGPoint(x: size.width/2, y: 320)
        
        return label
    }()
    lazy var newHighscoreLabel: SKSpriteNode = {
        let sprite = SKSpriteNode(pixelImageNamed: "NewHighscoreLabel")
        
        sprite.zRotation = 22.5 * CGFloat.pi/180
        sprite.position = CGPoint(x: 240, y: scoreLabel.position.y-20)
        
        return sprite
    }()
    lazy var tryAgainButton: ButtonNode = {
        let button = ButtonNode(defaultTexture: "TryAgainButtonDefault", pressedTexture: "TryAgainButtonPressed") { [self] in
            view?.presentScene(GameScene.newScene())
        }
        
        button.position = CGPoint(x: size.width/2, y: 160)
        
        return button
    }()
    lazy var menuButton: ButtonNode = {
        let button = ButtonNode(defaultTexture: "MainMenuButtonDefault", pressedTexture: "MainMenuButtonPressed") { [self] in
            view?.presentScene(MainMenuScene.newScene())
        }
        
        button.position = CGPoint(x: tryAgainButton.position.x, y: tryAgainButton.position.y-48)
        
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
        label.position = CGPoint(x: tryAgainButton.position.x, y: tryAgainButton.position.y+tryAgainButton.frame.height/2+16)
        
        return label
    }()
    
    func setUpScene() {
        view?.ignoresSiblingOrder = true
        
        addChild(background)
        addChild(gameOverLabel0)
        addChild(gameOverLabel1)
        addChild(scoreLabel)
        if GameController.shared.isNewHighscore {
            addChild(newHighscoreLabel)
        }
        addChild(tryAgainButton)
        addChild(menuButton)
        if GameController.shared.highscore > 0 {
            addChild(highscoreLabel)
        }
        
        if !GameController.shared.isSfxMuted {
            run(.playSoundFileNamed("GameOver.wav", waitForCompletion: false))
        }
    }
    
    override func didMove(to view: SKView) {
        setUpScene()
    }
}
