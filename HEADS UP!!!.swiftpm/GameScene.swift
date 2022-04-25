//
//  File.swift
//  SwiftStudentChallenge2022
//
//  Created by Vitor Grechi Kuninari on 23/04/2022.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    class func newScene() -> GameScene {
        let newScene = GameScene(size: .defaultSceneSize)
        newScene.scaleMode = .aspectFill
        return newScene
    }
    
    lazy var currentSpawners: Int = 0
    
    lazy var background: SKSpriteNode = {
        let sprite = SKSpriteNode(pixelImageNamed: "Background")
        
        sprite.zPosition = .zBackground
        sprite.position = CGPoint(x: size.width/2, y: size.height/2)
        
        return sprite
    }()
    lazy var planet: PlanetNode = {
        let planet = PlanetNode()
        
        planet.position = CGPoint(x: size.width/2, y: size.height/2)
        
        return planet
    }()
    lazy var currentScoreLabel: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: String(GameController.shared.currentScore),
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 80, weight: .regular),
                .foregroundColor: UIColor.white
            ]
        ))
        label.setScale(1/4)
        
        label.zPosition = .zHud
        label.position = CGPoint(x: size.width/2, y: size.height-40)
        
        return label
    }()
    lazy var pauseButton: ButtonNode = {
        let button = ButtonNode(defaultTexture: "PauseButtonDefault", pressedTexture: "PauseButtonPressed") { [self] in
            isPaused = true
            showPauseScreen()
        }
        
        button.zPosition = .zHud
        button.position = CGPoint(x: size.width-32, y: size.height-32)
        
        return button
    }()
    lazy var fadeNode: SKShapeNode = {
        let node = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        node.name = "Fade"
        node.fillColor = .black
        node.lineWidth = 0
        node.alpha = 2/3
        
        node.zPosition = .zHud + 1
        
        return node
    }()
    lazy var countdownCounter: Int = 3
    lazy var countdownTimer = Timer()
    lazy var countdownText: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: String(countdownCounter),
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 256, weight: .regular),
                .foregroundColor: UIColor.white
            ]
        ))
        label.verticalAlignmentMode = .center
        label.setScale(1/4)
        
        label.zPosition = fadeNode.zPosition + 1
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        
        return label
    }()
    lazy var resumeButton: ButtonNode = {
        let button = ButtonNode(defaultTexture: "ResumeButtonDefault", pressedTexture: "ResumeButtonPressed") { [self] in
            startResumeCountdown()
        }
        
        button.zPosition = fadeNode.zPosition + 1
        button.position = CGPoint(x: size.width/2, y: size.height/2)
        
        return button
    }()
    lazy var menuButton: ButtonNode = {
        let button = ButtonNode(defaultTexture: "MainMenuButtonDefault", pressedTexture: "MainMenuButtonPressed") { [self] in
            view?.presentScene(MainMenuScene.newScene())
        }
        
        button.zPosition = resumeButton.zPosition
        button.position = CGPoint(x: resumeButton.position.x, y: resumeButton.position.y-48)
        
        return button
    }()
    
    func setUpScene() {
        view?.ignoresSiblingOrder = true
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        addChild(background)
        
        GameController.shared.resetScore()
        GameController.shared.resetGame()
        
        addChild(currentScoreLabel)
        addChild(pauseButton)
        
        addChild(planet)
        
        enemySpawner()
        currentSpawners += 1
    }
    
    override func didMove(to view: SKView) {
        setUpScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
        currentScoreLabel.attributedText = NSAttributedString(
            string: String(GameController.shared.currentScore),
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 80, weight: .regular),
                .foregroundColor: UIColor.white
            ]
        )
    }
    
    func enemySpawner() {
        let enemy = EnemyNode()
        enemy.position = CGPoint(x: size.width/2, y: size.height/2)
        let angle = CGFloat.random(in: 0...CGFloat.pi*2)
        let dX: CGFloat = cos(angle) * (size.width+50)
        let dY: CGFloat = sin(angle) * (size.height+50)
        enemy.run(.move(by: CGVector(dx: dX, dy: dY), duration: 0))
        enemy.run(.move(to: planet.position, duration: TimeInterval.random(in: GameController.shared.initialMoveSpeed...(GameController.shared.initialMoveSpeed+0.25))))
        addChild(enemy)
        
        if GameController.shared.initialMoveSpeed > 1 {
            GameController.shared.initialMoveSpeed -= 0.025
        }
        if GameController.shared.enemySpawnRate > 0.5 {
            GameController.shared.enemySpawnRate -= 0.025
        }
        
        if GameController.shared.currentScore == 10 && currentSpawners == 1 {
            run(.wait(forDuration: 0.25)) { [self] in
                currentSpawners += 1
                GameController.shared.initialMoveSpeed = 6
                GameController.shared.enemySpawnRate = 3.5
                enemySpawner()
            }
        } else if GameController.shared.currentScore == 25 && currentSpawners == 2 {
            run(.wait(forDuration: 0.25)) { [self] in
                currentSpawners += 1
                GameController.shared.initialMoveSpeed = 6
                GameController.shared.enemySpawnRate = 4
                enemySpawner()
            }
        } else if GameController.shared.currentScore == 50 && currentSpawners == 3 {
            run(.wait(forDuration: 0.25)) { [self] in
                currentSpawners += 1
                GameController.shared.initialMoveSpeed = 6
                GameController.shared.enemySpawnRate = 4.5
                enemySpawner()
            }
        } else if GameController.shared.currentScore == 100 && currentSpawners == 4 {
            run(.wait(forDuration: 0.25)) { [self] in
                currentSpawners += 1
                GameController.shared.initialMoveSpeed = 6
                GameController.shared.enemySpawnRate = 5
                enemySpawner()
            }
        } else if GameController.shared.currentScore == 200 && currentSpawners == 5 {
            run(.wait(forDuration: 0.25)) { [self] in
                currentSpawners += 1
                GameController.shared.initialMoveSpeed = 6
                GameController.shared.enemySpawnRate = 5.5
                enemySpawner()
            }
            run(.wait(forDuration: 1/3)) { [self] in
                currentSpawners += 1
                GameController.shared.initialMoveSpeed = 6
                GameController.shared.enemySpawnRate = 5.5
                enemySpawner()
            }
        }
        
        run(.wait(forDuration: TimeInterval.random(in: GameController.shared.enemySpawnRate...(GameController.shared.enemySpawnRate+0.5)))) { [self] in
            enemySpawner()
        }
    }
    
    func showPauseScreen() {
        addChild(fadeNode)
        addChild(resumeButton)
        addChild(menuButton)
    }
    
    func startResumeCountdown() {
        resumeButton.removeFromParent()
        menuButton.removeFromParent()
        countdownText.attributedText = NSAttributedString(
            string: String(countdownCounter),
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 256, weight: .semibold),
                .foregroundColor: UIColor.white
            ]
        )
        addChild(countdownText)
        countdownTimer = .scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    @objc func countdown() {
        if countdownCounter <= 1 {
            countdownText.removeFromParent()
            fadeNode.removeFromParent()
            isPaused = false
            countdownTimer.invalidate()
            countdownCounter = 3
        } else {
            countdownCounter -= 1
            countdownText.attributedText = NSAttributedString(
                string: String(countdownCounter),
                attributes: [
                    .font: UIFont.monospacedSystemFont(ofSize: 256, weight: .semibold),
                    .foregroundColor: UIColor.white
                ]
            )
        }
    }
    
    // MARK: --- SKPhysicsContactDelegate
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "Planet" {
            contactBetween(planet: nodeA, object: nodeB)
        } else if nodeB.name == "Planet" {
            contactBetween(planet: nodeB, object: nodeA)
        }
    }
    
    func contactBetween(planet: SKNode, object: SKNode) {
        switch object {
            case is EnemyNode:
                GameController.shared.saveScore()
                view?.presentScene(GameOverScene.newScene())
            default:
                break
        }
    }
}
