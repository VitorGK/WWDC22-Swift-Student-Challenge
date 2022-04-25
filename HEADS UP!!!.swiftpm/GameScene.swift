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
            speed = 0
            showPauseScreen()
        }
        button.anchorPoint = CGPoint(x: 1, y: 1)
        
        button.position = CGPoint(x: size.width-32, y: size.height-24)
        
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
    lazy var toggleSfx: ToggleNode = {
        let button = ToggleNode(status: !GameController.shared.isSfxMuted, defaultTextureOn: "SoundOnButtonDefault", pressedTextureOn: "SoundOnButtonPressed", defaultTextureOff: "SoundOffButtonDefault", pressedTextureOff: "SoundOffButtonPressed") {
            GameController.shared.isSfxMuted = false
            UserDefaults().set(false, forKey: "isSfxMuted")
            print("Sound ON")
        } actionOff: {
            GameController.shared.isSfxMuted = true
            UserDefaults().set(true, forKey: "isSfxMuted")
            print("Sound OFF")
        }
        button.anchorPoint = CGPoint(x: 1, y: 1)
        
        button.zPosition = resumeButton.zPosition
        button.position = CGPoint(x: size.width-32, y: pauseButton.position.y-pauseButton.size.height-8)
        
        return button
    }()
    
    let hand = SKSpriteNode(pixelImageNamed: "Hand")
    var firstEnemy: EnemyNode?
    
    func setUpScene() {
        view?.ignoresSiblingOrder = true
        view?.isMultipleTouchEnabled = true
        
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
        
        if !UserDefaults().bool(forKey: "isOldUser") {
            children.forEach { child in
                guard let enemy = child as? EnemyNode else { return }
                enemy.isUserInteractionEnabled = false
                enemy.zPosition = fadeNode.zPosition + 1
                hand.anchorPoint = CGPoint(x: -0.25, y: 1.25)
                hand.zPosition = enemy.zPosition + 1
                run(.wait(forDuration: 4.5)) { [self] in
                    addChild(fadeNode)
                    speed = 0
                    firstEnemy = enemy
                    hand.position = enemy.position
                    addChild(hand)
                }
            }
        }
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstEnemy = firstEnemy {
            for touch in touches {
                let location = touch.location(in: self)
                let touchedNode = self.nodes(at: location)
                for node in touchedNode {
                    if node.name == "Enemy" {
                        UserDefaults().set(true, forKey: "isOldUser")
                        fadeNode.removeFromParent()
                        hand.removeFromParent()
                        speed = 1
                        firstEnemy.isUserInteractionEnabled = false
                        firstEnemy.zPosition = firstEnemy.zPosition - 2
                        GameController.shared.increaseScore()
                        let explosion = SKSpriteNode(pixelImageNamed: "Explosion" + String(Int.random(in: 0...2)))
                        let angles: [CGFloat] = [0, 90, 180, 270]
                        explosion.zRotation = angles.randomElement()! * CGFloat.pi / 180
                        explosion.zPosition = zPosition + 1
                        firstEnemy.addChild(explosion)
                        firstEnemy.removeAllActions()
                        if !GameController.shared.isSfxMuted {
                            firstEnemy.run(.playSoundFileNamed(firstEnemy.sounds.randomElement()!, waitForCompletion: false))
                        }
                        firstEnemy.run(.fadeOut(withDuration: 0.5)) {
                            firstEnemy.removeFromParent()
                        }
                        self.firstEnemy = nil
                    }
                }
            }
        }
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
        
        if GameController.shared.initialMoveSpeed > 0.5 {
            GameController.shared.initialMoveSpeed -= 0.05
        }
        if GameController.shared.enemySpawnRate > 0.25 {
            GameController.shared.enemySpawnRate -= 0.05
        }
        
        if GameController.shared.currentScore == 10-1 && currentSpawners == 1 {
            run(.wait(forDuration: 0.25)) { [self] in
                currentSpawners += 1
                GameController.shared.initialMoveSpeed = 6
                GameController.shared.enemySpawnRate = 2.5
                enemySpawner()
            }
        } else if GameController.shared.currentScore == 25-1 && currentSpawners == 2 {
            run(.wait(forDuration: 0.25)) { [self] in
                currentSpawners += 1
                GameController.shared.initialMoveSpeed = 6
                GameController.shared.enemySpawnRate = 3
                enemySpawner()
            }
        } else if GameController.shared.currentScore == 50-1 && currentSpawners == 3 {
            run(.wait(forDuration: 0.25)) { [self] in
                currentSpawners += 1
                GameController.shared.initialMoveSpeed = 6
                GameController.shared.enemySpawnRate = 3.5
                enemySpawner()
            }
        } else if GameController.shared.currentScore == 100-1 && currentSpawners == 4 {
            run(.wait(forDuration: 0.25)) { [self] in
                currentSpawners += 1
                GameController.shared.initialMoveSpeed = 6
                GameController.shared.enemySpawnRate = 4
                enemySpawner()
            }
        } else if GameController.shared.currentScore == 200-1 && currentSpawners == 5 {
            run(.wait(forDuration: 0.25)) { [self] in
                currentSpawners += 1
                GameController.shared.initialMoveSpeed = 6
                GameController.shared.enemySpawnRate = 4.5
                enemySpawner()
            }
            run(.wait(forDuration: 1/3)) { [self] in
                currentSpawners += 1
                GameController.shared.initialMoveSpeed = 6
                GameController.shared.enemySpawnRate = 4.5
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
        addChild(toggleSfx)
    }
    
    func startResumeCountdown() {
        resumeButton.removeFromParent()
        menuButton.removeFromParent()
        toggleSfx.removeFromParent()
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
            speed = 1
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
