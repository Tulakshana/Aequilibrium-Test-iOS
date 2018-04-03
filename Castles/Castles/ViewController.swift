//
//  ViewController.swift
//  Castles
//
//  Created by Tulakshana on 4/1/18.
//  Copyright © 2018 Tulakshana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtIntegers: UITextField!

    let calculator: CastleCalculator = CastleCalculator()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -
    
    @IBAction func btnCalculateTapped(_ sender: UIButton) {
        
        if let heightsString = txtIntegers.text {
            
            let castleCount: Int = calculator.calculateCastles(heightsString)
            var message: String = ""
            if castleCount == 0 {
                message = "No castles can be built or the array inserted is not in the correct format."
            } else {
                message = String(castleCount) + " castle"
                if castleCount > 1 {
                    message += "s"
                }
                message += " can be built."
            }
            
            let alert: UIAlertController = UIAlertController.init(title: "Castles", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (_) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func btnSample1Tapped(_ sender: UIButton) {
        txtIntegers.text = calculator.sampleIntegerArray1()
    }
    
    @IBAction func btnSample2Tapped(_ sender: UIButton) {
        txtIntegers.text = calculator.sampleIntegerArray2()
    }
    
    @IBAction func btnSample3Tapped(_ sender: UIButton) {
        txtIntegers.text = calculator.sampleIntegerArray3()
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

