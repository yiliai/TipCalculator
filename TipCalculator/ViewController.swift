//
//  ViewController.swift
//  TipCalculator
//
//  Created by Yili Aiwazian on 8/21/14.
//  Copyright (c) 2014 Yili Aiwazian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipChooser: UISegmentedControl!
    
    var billAmount = 0.0
    var tipAmount = 0.0
    var totalAmount = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var formatter = NSNumberFormatter()
        formatter.locale = NSLocale.currentLocale()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        println(formatter.stringFromNumber(10000))
        
        //tipLabel.text = String(format: "%@%.2f", formatter.currencySymbol, tipAmount)
        //totalLabel.text = String(format: "%@%.2f", formatter.currencySymbol, totalAmount)
        
        tipLabel.text = formatter.stringFromNumber(tipAmount)
        totalLabel.text = formatter.stringFromNumber(totalAmount)
        
        for (index, value) in enumerate(Settings.tipPercentages) {
            var amount = String (format: "%.0f%%", value*100)
            tipChooser.setTitle (amount, forSegmentAtIndex: index)
        }

        
        println("locale: \(formatter.currencySymbol)")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        var defaults = NSUserDefaults.standardUserDefaults()
        
        Settings.defaultIndex = defaults.integerForKey("DefaultTipIndex")
        tipChooser.selectedSegmentIndex = Settings.defaultIndex
        
        if ((defaults.objectForKey("BillField")) != nil && (defaults.objectForKey("BillLastSet")) != nil) {
            
            var billLastSet = defaults.objectForKey("BillLastSet") as NSDate
            var timeInterval = billLastSet.timeIntervalSinceNow
            
            if (timeInterval >= saveBillFor) {
                billField.text = defaults.objectForKey("BillField") as String
                onEditingChanged(self)
            }
        }
        
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //println("view will disappear")
        
        /*
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billField.text, forKey: "BillField")
        defaults.setObject(NSDate(), forKey: "BillLastSet")
        defaults.synchronize()
        */
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
                
        var tipPercentage = Settings.tipPercentages[tipChooser.selectedSegmentIndex]
        
        billAmount = billField.text._bridgeToObjectiveC().doubleValue
    
        tipAmount = billAmount * tipPercentage
        totalAmount = billAmount + tipAmount
        
        var formatter = NSNumberFormatter()
        formatter.locale = NSLocale.currentLocale()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle

        tipLabel.text = formatter.stringFromNumber(tipAmount)
        totalLabel.text = formatter.stringFromNumber(totalAmount)
        
        //tipLabel.text = String(format: "%@%.2f", formatter.currencySymbol, tipAmount)
        //totalLabel.text = String(format: "%@%.2f", formatter.currencySymbol, totalAmount)
        
    }

    //Tap anywhere to dismiss the keyboard
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
        
    }
    
    
    
}

