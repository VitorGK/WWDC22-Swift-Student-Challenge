//
//  File.swift
//  SwiftStudentChallenge2022
//
//  Created by Vitor Grechi Kuninari on 23/04/2022.
//

import Foundation

class GameController {
    static var shared: GameController = {
        return GameController()
    }()
    
    var initialScene: MainMenuScene {
        .newScene()
    }
    
    var isNewHighscore: Bool = false
    var highscore: Int {
        UserDefaults().integer(forKey: "Highscore")
    }
    var currentScore: Int = 0
    
    var initialMoveSpeed: TimeInterval = 6
    var enemySpawnRate: TimeInterval = 3
    
    private init() {}
    
    func increaseScore(by value: Int = 1) {
        currentScore += value
    }
    
    func saveScore() {
        if currentScore > highscore {
            isNewHighscore = true
            UserDefaults().set(currentScore, forKey: "Highscore")
        }
    }
    
    func resetScore() {
        isNewHighscore = false
        currentScore = 0
    }
    
    func resetGame() {
        initialMoveSpeed = 6
        enemySpawnRate = 3
    }
}
