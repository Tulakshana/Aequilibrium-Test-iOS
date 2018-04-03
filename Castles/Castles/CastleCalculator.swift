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
    case none
}

class CastleCalculator {
    
    func sampleIntegerArray1() -> String{
        return "2,6,6,6,3,6,1,4,5,4,3,2,7"
    }
    
    // An array starting with a valley
    func sampleIntegerArray2() -> String{
        return "2,2,2,6,6,6,3,6,1,4,5,4,3,2,7,7,7,7,5,3,2,2,2,2,3,6,8,7"
    }
    
    // An array with only one peak
    func sampleIntegerArray3() -> String{
        return "2,6,6,6,3"
    }
    
    func calculateCastles(_ heights: String) -> Int {
        var castleCount: Int = 0
        let heightsArray = heights.components(separatedBy: ",")
        if heightsArray.count > 1 {
            var movingDirection: Direction = .none
            var lastReadHeight: Int = 0
            for height in heightsArray {
                if let currentHeight = Int(height) {
                    if currentHeight > lastReadHeight {
                        if (movingDirection == .down) || (movingDirection == .same) {
                            // we have detected a valley
                            castleCount += 1
                        }
                        movingDirection = .up
                    } else if currentHeight < lastReadHeight {
                        if (movingDirection == .up) || (movingDirection == .same) {
                            // we have detected a peak
                            castleCount += 1
                        }
                        movingDirection = .down
                    } else if currentHeight == lastReadHeight {
                        movingDirection = .same
                    }
                    lastReadHeight = currentHeight
                }
            }
        }
        return castleCount
    }
}
