//
//  BattleManager.swift
//  Transformers
//
//  Created by Tulakshana on 4/2/18.
//  Copyright © 2018 Tulakshana. All rights reserved.
//

import Foundation

class BattleManager {
    
    static let shared = BattleManager()
    
    func transformers() -> [Transformer] {
        
        if let path = NSBundle.mainBundle().pathForResource("Transformers", ofType: "plist") {
            let plist = NSArray(contentsOfFile: path)
        }
        return []
    }
}
