//
//  EggHardness.swift
//  EggTimer
//
//  Created by OmarAssidi on 21/09/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

enum EggHardness: String {
    case soft = "Soft"
    case medium = "Medium"
    case hard = "Hard"
    
    func getRequiredTime() -> Int {
        switch self {
        case .soft:
            return 5
        case .medium:
            return 420
        case .hard:
            return 720
        }
    }
}
