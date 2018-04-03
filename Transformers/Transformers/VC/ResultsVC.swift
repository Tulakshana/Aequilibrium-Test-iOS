//
//  ResultsVC.swift
//  Transformers
//
//  Created by Tulakshana on 4/2/18.
//  Copyright © 2018 Tulakshana. All rights reserved.
//

import UIKit

class ResultsVC: UIViewController {
    
    @IBOutlet var resultsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsTextView.text = BattleManager.shared.calculateScore()
    }
    
    // MARK: -
    
    @IBAction func btnOkTapped(_ sender: UIButton) {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
}
