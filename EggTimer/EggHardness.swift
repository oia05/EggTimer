//
//  EggHardness.swift
//  EggTimer
//
//  Created by Omar Assidi on 23/11/2024.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

enum EggHardness: Float {
    case soft = 10.0
    case medium = 600.0
    case hard = 900.0
    
    func getName() -> String {
        switch self {
        case .soft: return "Soft"
        case .medium: return "Medium"
        case .hard: return "Hard"
        }
    }
}
