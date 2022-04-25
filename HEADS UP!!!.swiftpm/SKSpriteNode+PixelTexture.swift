//
//  File.swift
//  SwiftStudentChallenge2022
//
//  Created by Vitor Grechi Kuninari on 23/04/2022.
//

import SpriteKit

extension SKSpriteNode {
    convenience init(pixelImageNamed: String) {
        self.init(imageNamed: pixelImageNamed)
        texture?.filteringMode = .nearest
    }
}
