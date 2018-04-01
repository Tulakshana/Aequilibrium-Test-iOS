//
//  CastleCalculator.swift
//  Castles
//
//  Created by Tulakshana on 4/1/18.
//  Copyright © 2018 Tulakshana. All rights reserved.
//

import Foundation

enum Direction {
    case up
    case down
    case same
}

class CastleCalculator {
    
    func sampleIntegerArray1() -> String{
        return "2,6,6,6,3,6,1,4,5,4,3,2,7"
    }
    
    // An array staring with a peak
    func sampleIntegerArray2() -> String{
        return "2,2,2,6,6,6,3,6,1,4,5,4,3,2,7"
    }
    
    func calculateCastles(heights: String) -> Int {
        let heightsArray = heights.componentsSeparatedByString(",")
        if heightsArray.count > 1 {
            var movingDirection:Direction
            for height in heightsArray {
                
            }
        }
        return 0
    }
}