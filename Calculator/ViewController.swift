//
//  ViewController.swift
//  Calculator
//
//  Created by JiaShu Huang on 2019/3/19.
//  Copyright © 2019 JiaShu Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dispaly:UILabel!
    var userIsInTheMiddleOfTyping:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func touchDigit(_ sender:UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = dispaly.text!
            dispaly.text = textCurrentlyInDisplay + digit
        }else {
            dispaly.text = digit
            userIsInTheMiddleOfTyping = true
        }

    }
    var displayValue:Double {
        get {
            return Double(dispaly.text!)!
        }
        set {
            dispaly.text = String(newValue)
        }
    }
    
    private var brain = CalcuatorBrain()
    
    @IBAction func performOpreation(_ sender:UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
    }

}

