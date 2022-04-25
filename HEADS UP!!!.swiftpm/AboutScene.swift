//
//  File.swift
//  SwiftStudentChallenge2022
//
//  Created by Vitor Grechi Kuninari on 23/04/2022.
//

import SpriteKit

class AboutScene: SKScene {
    class func newScene() -> AboutScene {
        let newScene = AboutScene(size: .defaultSceneSize)
        newScene.scaleMode = .aspectFill
        return newScene
    }
    
    lazy var backButton: ButtonNode = {
        let button = ButtonNode(defaultTexture: "BackButtonDefault", pressedTexture: "BackButtonPressed") { [self] in
            view?.presentScene(MainMenuScene.newScene())
        }
        button.anchorPoint = CGPoint(x: 0, y: 1)
        
        button.position = CGPoint(x: 32, y: size.height-24)
        
        return button
    }()
    
    lazy var profile: SKSpriteNode = {
        let sprite = SKSpriteNode(pixelImageNamed: "Profile")
        sprite.anchorPoint = CGPoint(x: 0, y: 1)
        sprite.setScale(2)
        
        sprite.position = CGPoint(x: 32, y: size.height-64)
        
        return sprite
    }()
    lazy var aboutText00: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: "Hello there!",
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 64, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        ))
        label.numberOfLines = 0
        label.verticalAlignmentMode = .top
        label.horizontalAlignmentMode = .left
        label.setScale(1/4)
        
        label.position = CGPoint(x: profile.position.x+profile.size.width+16, y: profile.position.y+3)
        
        return label
    }()
    lazy var aboutText01: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: "My name is Vitor Grechi Kuninari, and I'm the\ndeveloper behind this game.",
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 28, weight: .regular),
                .foregroundColor: UIColor.white
            ]
        ))
        label.numberOfLines = 0
        label.verticalAlignmentMode = .top
        label.horizontalAlignmentMode = .left
        label.setScale(1/4)
        
        label.position = CGPoint(x: aboutText00.position.x, y: aboutText00.position.y-aboutText00.frame.height-8)
        
        return label
    }()
    lazy var aboutText02: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: "I'm a brazilian guy who likes to play video games, code and make\nmusic.",
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 28, weight: .regular),
                .foregroundColor: UIColor.white
            ]
        ))
        label.numberOfLines = 0
        label.verticalAlignmentMode = .top
        label.horizontalAlignmentMode = .left
        label.setScale(1/4)
        
        label.position = CGPoint(x: profile.position.x, y: profile.position.y-profile.size.height-8)
        
        return label
    }()
    lazy var aboutText03: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: "The space is also a big passion of mine. My childhood dream was to\nbe an astronaut. I still want to experience zero gravity, to explore\nthe universe, to see the stars, satellites, nebulae (my favorites),\nblack holes...",
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 28, weight: .regular),
                .foregroundColor: UIColor.white
            ]
        ))
        label.numberOfLines = 0
        label.verticalAlignmentMode = .top
        label.horizontalAlignmentMode = .left
        label.setScale(1/4)
        
        label.position = CGPoint(x: aboutText02.position.x, y: aboutText02.position.y-aboutText02.frame.height-8)
        
        return label
    }()
    lazy var aboutText04: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: "That inspired me to create something related to the space.",
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 28, weight: .regular),
                .foregroundColor: UIColor.white
            ]
        ))
        label.numberOfLines = 0
        label.verticalAlignmentMode = .top
        label.horizontalAlignmentMode = .left
        label.setScale(1/4)
        
        label.position = CGPoint(x: aboutText03.position.x, y: aboutText03.position.y-aboutText03.frame.height-8)
        
        return label
    }()
    lazy var aboutText05: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: "What if Earth was in danger?",
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 40, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        ))
        label.numberOfLines = 0
        label.verticalAlignmentMode = .top
        label.horizontalAlignmentMode = .left
        label.setScale(1/4)
        
        label.position = CGPoint(x: aboutText04.position.x, y: aboutText04.position.y-aboutText04.frame.height-16)
        
        return label
    }()
    lazy var aboutText06: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: "(The perfect sci-fi cliché)",
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 28, weight: .regular),
                .foregroundColor: UIColor.white
            ]
        ))
        label.numberOfLines = 0
        label.verticalAlignmentMode = .top
        label.horizontalAlignmentMode = .left
        label.setScale(1/4)
        
        label.position = CGPoint(x: aboutText05.position.x, y: aboutText05.position.y-aboutText05.frame.height-8)
        
        return label
    }()
    lazy var aboutText07: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: "Suddenly, everything decided to head towards our planet, and the\nonly thing that could save it is you... or better: your finger!",
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 28, weight: .regular),
                .foregroundColor: UIColor.white
            ]
        ))
        label.numberOfLines = 0
        label.verticalAlignmentMode = .top
        label.horizontalAlignmentMode = .left
        label.setScale(1/4)
        
        label.position = CGPoint(x: aboutText06.position.x, y: aboutText06.position.y-aboutText06.frame.height-8)
        
        return label
    }()
    lazy var aboutText08: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: "Do you want to know what came out of that premise? Just go back to\nthe main menu and tap on the PLAY button.",
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 28, weight: .regular),
                .foregroundColor: UIColor.white
            ]
        ))
        label.numberOfLines = 0
        label.verticalAlignmentMode = .top
        label.horizontalAlignmentMode = .left
        label.setScale(1/4)
        
        label.position = CGPoint(x: aboutText07.position.x, y: aboutText07.position.y-aboutText07.frame.height-8)
        
        return label
    }()
    lazy var aboutText09: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: "Just one more thing...",
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 40, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        ))
        label.numberOfLines = 0
        label.verticalAlignmentMode = .top
        label.horizontalAlignmentMode = .left
        label.setScale(1/4)
        
        label.position = CGPoint(x: aboutText08.position.x, y: aboutText08.position.y-aboutText08.frame.height-16)
        
        return label
    }()
    lazy var aboutText10: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: "I hope you’ve had a great experience playing this game!",
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 28, weight: .regular),
                .foregroundColor: UIColor.white
            ]
        ))
        label.numberOfLines = 0
        label.verticalAlignmentMode = .top
        label.horizontalAlignmentMode = .left
        label.setScale(1/4)
        
        label.position = CGPoint(x: aboutText09.position.x, y: aboutText09.position.y-aboutText09.frame.height-8)
        
        return label
    }()
    lazy var aboutText11: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: "My everyday goal is to make someone's day better, and that's why I\ncreate games, music etc.",
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 28, weight: .regular),
                .foregroundColor: UIColor.white
            ]
        ))
        label.numberOfLines = 0
        label.verticalAlignmentMode = .top
        label.horizontalAlignmentMode = .left
        label.setScale(1/4)
        
        label.position = CGPoint(x: aboutText10.position.x, y: aboutText10.position.y-aboutText10.frame.height-8)
        
        return label
    }()
    lazy var aboutText12: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: "My stuff",
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 40, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        ))
        label.numberOfLines = 0
        label.verticalAlignmentMode = .top
        label.horizontalAlignmentMode = .left
        label.setScale(1/4)
        
        label.position = CGPoint(x: aboutText11.position.x, y: aboutText11.position.y-aboutText11.frame.height-16)
        
        return label
    }()
    lazy var aboutText13: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: "GitHub: VitorGK",
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 28, weight: .regular),
                .foregroundColor: UIColor.white
            ]
        ))
        label.numberOfLines = 0
        label.verticalAlignmentMode = .top
        label.horizontalAlignmentMode = .left
        label.setScale(1/4)
        
        label.position = CGPoint(x: aboutText12.position.x, y: aboutText12.position.y-aboutText12.frame.height-8)
        
        return label
    }()
    lazy var aboutText14: SKLabelNode = {
        let label = SKLabelNode(attributedText: NSAttributedString(
            string: "SoundCloud: VitorGK",
            attributes: [
                .font: UIFont.monospacedSystemFont(ofSize: 28, weight: .regular),
                .foregroundColor: UIColor.white
            ]
        ))
        label.numberOfLines = 0
        label.verticalAlignmentMode = .top
        label.horizontalAlignmentMode = .left
        label.setScale(1/4)
        
        label.position = CGPoint(x: aboutText13.position.x, y: aboutText13.position.y-aboutText13.frame.height-8)
        
        return label
    }()
    
    func setUpScene() {
        view?.ignoresSiblingOrder = true
        backgroundColor = UIColor(white: 1/12, alpha: 1)
        
        addChild(profile)
        addChild(backButton)
        addChild(aboutText00)
        addChild(aboutText01)
        addChild(aboutText02)
        addChild(aboutText03)
        addChild(aboutText04)
        addChild(aboutText05)
        addChild(aboutText06)
        addChild(aboutText07)
        addChild(aboutText08)
        addChild(aboutText09)
        addChild(aboutText10)
        addChild(aboutText11)
        addChild(aboutText12)
        addChild(aboutText13)
        addChild(aboutText14)
    }
    
    override func didMove(to view: SKView) {
        setUpScene()
    }
}
