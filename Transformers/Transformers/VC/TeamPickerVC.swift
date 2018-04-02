//
//  TeamPickerVC.swift
//  Transformers
//
//  Created by Tulakshana on 4/2/18.
//  Copyright © 2018 Tulakshana. All rights reserved.
//

import UIKit

enum Team: String {
    case team1 = "Team 1"
    case team2 = "Team 2"
    case undefined = "Unkown"
}

class TeamPickerVC: UIViewController {
    
    var transformers: [Transformer] = []
    var team: Team = .undefined
    
    @IBOutlet var table: UITableView!
    @IBOutlet var lblCount: UILabel!
    @IBOutlet var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTransformers()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.selectTransformers()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if team == .team2 {
            BattleManager.shared.team2 = table.indexPathsForSelectedRows
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if segue.identifier == Segues.team2Segue.rawValue, let vc = segue.destinationViewController as? TeamPickerVC {
            vc.team = .team2
            BattleManager.shared.team1 = table.indexPathsForSelectedRows
        }
    }
    
    // MARK: -
    
    func loadTransformers() {
        transformers = BattleManager.transformers
        table.reloadData()
    }
    
    func selectTransformers() {
        if (team == .team2) && (table.indexPathsForSelectedRows == nil) {
            if let selectedIndexPaths = BattleManager.shared.team2 {
                for path in selectedIndexPaths {
                    table.selectRowAtIndexPath(path, animated: true, scrollPosition: .Top)
                }
                self.updateSelection()
            }
        }
    }
    
    func updateSelection() {
        if let count = table.indexPathsForSelectedRows?.count {
            btnNext.enabled = (count > 0)
            lblCount.text = "(" + String(count) + ") selected"
        } else {
            btnNext.enabled = false
            lblCount.text = "(0) selected"
        }
    }
}

extension TeamPickerVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transformers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("transformerCell")!
        
        let transformer = transformers[indexPath.row]
        cell.textLabel?.text = transformer.name
        cell.detailTextLabel?.text = "Function: " + transformer.function + " | Rating: " + String(transformer.spec.overallRating())
        cell.imageView?.image = UIImage.init(named: transformer.thumb)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.updateSelection()
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.updateSelection()
    }
}
