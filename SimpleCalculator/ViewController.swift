//
//  ViewController.swift
//  SimpleCalculator
//
//  Created by Austin Hill on 1/27/18.
//  Copyright © 2018 Austin Hill. All rights reserved.
//

import UIKit
import MathParser

class ViewController: UIViewController {
    
    @IBOutlet weak var l_output: UILabel!
    @IBOutlet weak var btn_ac: UIButton!
    @IBOutlet weak var btn_posneg: UIButton!
    @IBOutlet weak var btn_percent: UIButton!
    @IBOutlet weak var btn_div: UIButton!
    @IBOutlet weak var btn_mul: UIButton!
    @IBOutlet weak var btn_sub: UIButton!
    @IBOutlet weak var btn_add: UIButton!
    @IBOutlet weak var btn_equal: UIButton!
    @IBOutlet weak var btn_0: UIButton!
    @IBOutlet weak var btn_1: UIButton!
    @IBOutlet weak var btn_2: UIButton!
    @IBOutlet weak var btn_3: UIButton!
    @IBOutlet weak var btn_4: UIButton!
    @IBOutlet weak var btn_5: UIButton!
    @IBOutlet weak var btn_6: UIButton!
    @IBOutlet weak var btn_7: UIButton!
    @IBOutlet weak var btn_8: UIButton!
    @IBOutlet weak var btn_9: UIButton!
    @IBOutlet weak var btn_period: UIButton!
    var expression: String = "0"
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        var done: Bool = false
        
        /* Using the ASCII value from the tag, convert to the proper character for parsing
        and format the input string accordingly */
        
        // Reset the input string if AC pressed
        if sender.tag == 0 {
            expression = "0"
        }
        // Negate the input if +/- pressed
        else if sender.tag == 33 {
            expression = "-(" + expression + ")"
        }
        // Done calculating when = is pressed and don't pass it to input string
        else if sender.tag == 61 {
            done = !done
        }
        // Append all other button values to the input string
        else {
            expression.append(String(UnicodeScalar(UInt8(sender.tag.description)!)))
        }
        
        // Don't try to create an incomplete expression (i.e 8*, 9+, 5/, etc.)
        if CharacterSet.decimalDigits.contains(sender.titleLabel!.text!.unicodeScalars.first!) || sender.tag == 0 || sender.tag == 33 || sender.tag == 61 {

            do {
                
            // Evaluate and display the expression
            l_output.text! = String(try expression.evaluate())
            
            }
            catch {
                expression = "0"
                l_output.text! = "ERROR"
            }
        }
        
        if done {
            expression = l_output.text!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // prevent the statusbar from being washed out by the view background
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // reset the status bar to the default
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }


}

