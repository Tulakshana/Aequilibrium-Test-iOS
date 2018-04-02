//
//  TeamPickerVC.swift
//  Transformers
//
//  Created by Tulakshana on 4/2/18.
//  Copyright © 2018 Tulakshana. All rights reserved.
//

import UIKit

enum Team {
    case team1
    case team2
    case undefined
}

class TeamPickerVC: UIViewController {
    
    var transformers: [Transformer] = []
    var team: Team = .undefined
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTransformers()
    }
    
    // MARK: -
    
    func loadTransformers() {
        transformers = BattleManager.shared.transformers()
        table.reloadData()
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
        cell.detailTextLabel?.text = transformer.function
        cell.imageView?.image = UIImage.init(named: transformer.thumb)
        
        return cell
    }
}
