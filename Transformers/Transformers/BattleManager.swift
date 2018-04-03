//
//  BattleManager.swift
//  Transformers
//
//  Created by Tulakshana on 4/2/18.
//  Copyright © 2018 Tulakshana. All rights reserved.
//

import UIKit

enum Keys: String {
    case name
    case allegiance
    case thumb
    case function
    case specification
    case strength
    case intelligence
    case speed
    case endurance
    case rank
    case courage
    case firepower
    case skill
}

enum TransformerNames: String {
    case optimusPrime = "Optimus Prime"
    case predaking = "Predaking"
}

class BattleManager {
    
    static let shared = BattleManager()
    
    var team1: [IndexPath]?
    var team2: [IndexPath]?
    
    var team1Transformers: [Transformer] = []
    var team2Transformers: [Transformer] = []
    var survivingTeam1Members: [Transformer] = []
    var survivingTeam2Members: [Transformer] = []
    var battles: Int = 0
    
    static let transformers: [Transformer] = BattleManager.fetchTransformers()
    
    static func fetchTransformers() -> [Transformer] {
        var transformerArray: [Transformer] = []
        if let path = Bundle.main.path(forResource: "Transformers", ofType: "plist") {
            if let plist = NSArray(contentsOfFile: path) {
                for item in plist {
                    let transformer = Transformer()
                    transformer.name = (item as AnyObject).object(forKey: Keys.name.rawValue) as! String
                    transformer.allegiance = (item as AnyObject).object(forKey: Keys.allegiance.rawValue) as! String
                    transformer.thumb = (item as AnyObject).object(forKey: Keys.thumb.rawValue) as! String
                    transformer.function = (item as AnyObject).object(forKey: Keys.function.rawValue) as! String
                    
                    let spec = Specification()
                    let specDic = (item as AnyObject).object(forKey: Keys.specification.rawValue) as! NSDictionary
                    spec.strength = specDic.object(forKey: Keys.strength.rawValue) as! Int
                    spec.intelligence = specDic.object(forKey: Keys.intelligence.rawValue) as! Int
                    spec.speed = specDic.object(forKey: Keys.speed.rawValue) as! Int
                    spec.endurance = specDic.object(forKey: Keys.endurance.rawValue) as! Int
                    spec.rank = specDic.object(forKey: Keys.rank.rawValue) as! Int
                    spec.courage = specDic.object(forKey: Keys.courage.rawValue) as! Int
                    spec.firepower = specDic.object(forKey: Keys.firepower.rawValue) as! Int
                    spec.skill = specDic.object(forKey: Keys.skill.rawValue) as! Int
                    
                    transformer.spec = spec
                    
                    transformerArray.append(transformer)
                }
            }
        }
        return transformerArray.sorted(by: { (t1, t2) -> Bool in
            t1.name < t2.name
        })
    }
    
    func calculateScore() -> String {
        
        if (team2?.count)! > (team1?.count)! {
            battles = team1?.count ?? 0
        } else {
            battles = team2?.count ?? 0
        }
        
        team1Transformers = self.team1Members()
        team2Transformers = self.team2Members()
        
        survivingTeam1Members.removeAll()
        survivingTeam2Members.removeAll()
        
        for i in 0...(battles - 1) {
            let t1 = team1Transformers[i]
            let t2 = team2Transformers[i]
            
            if self.evaluateGameChanger(t1, team2Member: t2) {
                survivingTeam1Members.removeAll()
                survivingTeam2Members.removeAll()
                break
            } else if self.evaluateDuplicate(t1, team2Member: t2) {
                continue
            } else if self.evaluateSpecialRule(t1, team2Member: t2) {
                continue
            } else if self.evaluateCourageAndStrength(t1, team2Member: t2) {
                continue
            } else if self.evaluateSkill(t1, team2Member: t2) {
                continue
            } else if self.evaluateOverallRating(t1, team2Member: t2) {
                continue
            }
        }
        
        var score: String = String(battles) + " battle"
        if (battles == 0) || (battles > 1) {
            score += "s"
        }
        score += "\n\n"
        
        var winningTeam: Team = .undefined
        var lostTeam: Team = .undefined
        
        if survivingTeam1Members.count == survivingTeam2Members.count {
            score += "Nobody won"
        } else {
            if survivingTeam2Members.count > survivingTeam1Members.count {
                winningTeam = .team2
                lostTeam = .team1
            } else {
                winningTeam = .team1
                lostTeam = .team2
            }
            
            self.addIdleMembers()
            
            score += "Winning team (" + winningTeam.rawValue + "):\n"
            
            for t in survivingMembers(winningTeam) {
                score += t.name + "\n"
            }
            score += "\n"
            
            score += "Survivors   from   the   losing   team  (" + lostTeam.rawValue + "):\n"
            
            for t in survivingMembers(lostTeam) {
                score += t.name + "\n"
            }
            score += "\n"
        }
        return score
    }
    
    func team1Members() -> [Transformer] {
        var members: [Transformer] = []
        if let team = team1 {
            for path in team {
                members.append(BattleManager.transformers[path.row])
            }
        }
        return members.sorted(by: { (t1, t2) -> Bool in
            t1.spec.rank > t2.spec.rank
        })
    }
    
    func team2Members() -> [Transformer] {
        var members: [Transformer] = []
        if let team = team2 {
            for path in team {
                members.append(BattleManager.transformers[path.row])
            }
        }
        return members.sorted(by: { (t1, t2) -> Bool in
            t1.spec.rank > t2.spec.rank
        })
    }
    
    func evaluateCourageAndStrength(_ team1Member: Transformer, team2Member: Transformer) -> Bool {
        if (team1Member.spec.courage <= (team2Member.spec.courage - 4)) && (team1Member.spec.strength <= (team2Member.spec.strength - 3)) {
            survivingTeam2Members.append(team2Member)
        } else if (team2Member.spec.courage <= (team1Member.spec.courage - 4)) && (team2Member.spec.strength <= (team1Member.spec.strength - 3)) {
            survivingTeam1Members.append(team1Member)
        } else {
            return false
        }
        return true
    }
    
    func evaluateSkill(_ team1Member: Transformer, team2Member: Transformer) -> Bool {
        if team1Member.spec.skill <= (team2Member.spec.skill - 3) {
            survivingTeam2Members.append(team2Member)
        } else if team2Member.spec.skill <= (team1Member.spec.skill - 3) {
            survivingTeam1Members.append(team1Member)
        } else {
            return false
        }
        return true
    }
    
    func evaluateOverallRating(_ team1Member: Transformer, team2Member: Transformer) -> Bool {
        if team1Member.spec.overallRating() < team2Member.spec.overallRating() {
            survivingTeam2Members.append(team2Member)
        } else if team2Member.spec.overallRating() < team1Member.spec.overallRating() {
            survivingTeam1Members.append(team1Member)
        } else {
            return false
        }
        return true
    }
    
    func evaluateSpecialRule(_ team1Member: Transformer, team2Member: Transformer) -> Bool {
        if (team1Member.name == TransformerNames.optimusPrime.rawValue) || (team1Member.name == TransformerNames.predaking.rawValue) {
            survivingTeam1Members.append(team1Member)
        } else if (team2Member.name == TransformerNames.optimusPrime.rawValue) || (team2Member.name == TransformerNames.predaking.rawValue) {
            survivingTeam2Members.append(team2Member)
        } else {
            return false
        }
        return true
    }
    
    func evaluateDuplicate(_ team1Member: Transformer, team2Member: Transformer) -> Bool {
        if team1Member.name == team2Member.name {
            return true
        } else {
            return false
        }
    }
    
    func evaluateGameChanger(_ team1Member: Transformer, team2Member: Transformer) -> Bool {
        if ((team1Member.name == TransformerNames.optimusPrime.rawValue) || (team1Member.name == TransformerNames.predaking.rawValue)) && ((team2Member.name == TransformerNames.optimusPrime.rawValue) || (team2Member.name == TransformerNames.predaking.rawValue)){
            return true
        } else {
            return false
        }
    }
    
    func addIdleMembers() {
        if battles < team2Transformers.count {
            for i in battles...(team2Transformers.count - 1) {
                survivingTeam2Members.append(team2Transformers[i])
            }
        } else if battles < team1Transformers.count {
            for i in battles...(team1Transformers.count - 1) {
                survivingTeam1Members.append(team1Transformers[i])
            }
        }
    }
    
    func survivingMembers(_ team: Team) -> [Transformer] {
        if team == .team1 {
            return survivingTeam1Members
        } else if team == .team2 {
            return survivingTeam2Members
        }
        return []
    }
}
