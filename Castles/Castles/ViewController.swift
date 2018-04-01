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
    
    @IBAction func btnCalculateTapped(sender: UIButton) {
        
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
            
            let alert: UIAlertController = UIAlertController.init(title: "Castles", message: message, preferredStyle: .Alert)
            alert.addAction(UIAlertAction.init(title: "Ok", style: .Default, handler: { (_) in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func btnSample1Tapped(sender: UIButton) {
        txtIntegers.text = calculator.sampleIntegerArray1()
    }
    
    @IBAction func btnSample2Tapped(sender: UIButton) {
        txtIntegers.text = calculator.sampleIntegerArray2()
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

