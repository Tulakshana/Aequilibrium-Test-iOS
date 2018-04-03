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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.selectTransformers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if team == .team2 {
            BattleManager.shared.team2 = table.indexPathsForSelectedRows
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == Segues.team2Segue.rawValue, let vc = segue.destination as? TeamPickerVC {
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
                    table.selectRow(at: path as IndexPath, animated: true, scrollPosition: .top)
                }
                self.updateSelection()
            }
        }
    }
    
    func updateSelection() {
        if let count = table.indexPathsForSelectedRows?.count {
            btnNext.isEnabled = (count > 0)
            lblCount.text = "(" + String(count) + ") selected"
        } else {
            btnNext.isEnabled = false
            lblCount.text = "(0) selected"
        }
    }
}

extension TeamPickerVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transformers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transformerCell")!
        
        let transformer = transformers[indexPath.row]
        cell.textLabel?.text = transformer.name
        cell.detailTextLabel?.text = "Function: " + transformer.function + " | Rating: " + String(transformer.spec.overallRating())
        cell.imageView?.image = UIImage.init(named: transformer.thumb)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.updateSelection()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.updateSelection()
    }
}
