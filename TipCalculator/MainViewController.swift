//
//  MainViewController.swift
//  TipCalculator
//
//  Created by Yili Aiwazian on 8/24/14.
//  Copyright (c) 2014 Yili Aiwazian. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var billCurrencyLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var totalCurrencyLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tipChooser: UISegmentedControl!
    @IBOutlet weak var settingButton: UIBarButtonItem!
    
    var billAmount = 0.0
    var tipAmount = 0.0
    var totalAmount = 0.0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tipAmountLabel.text = formatCurrency(tipAmount, withSymbol: true)
        totalAmountLabel.text = formatCurrency(totalAmount, withSymbol: false)
        billCurrencyLabel.text = currencySymbol()
        totalCurrencyLabel.text = currencySymbol()

        // Populate the tip selection values
        for (index, value) in enumerate(tipPercentages) {
            var amount = String (format: "%.0f%%", value*100)
            tipChooser.setTitle (amount, forSegmentAtIndex: index)
        }
        
        billField.text = Settings.lastBillAmount
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var defaults = NSUserDefaults.standardUserDefaults()
        Settings.defaultIndex = defaults.integerForKey("DefaultTipIndex")
        Settings.theme = defaults.integerForKey("ThemeColor")
        
        if (Settings.cleanStart) {
            // Hide everything except for the bill portion
            tipChooser.alpha = 0
            totalCurrencyLabel.alpha = 0
            totalAmountLabel.alpha = 0
            separator.alpha = 0
            tipLabel.alpha = 0
            tipAmountLabel.alpha = 0
            tipChooser.selectedSegmentIndex = Settings.defaultIndex
        }
        else {
            moveUpBillSection()
            tipChooser.selectedSegmentIndex = Settings.lastTipIndex
        }
        
        changeColor()
        onEditingChanged(self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTouchDownBillField(sender: AnyObject) {
    
        if (Settings.cleanStart) {
            UIView.animateWithDuration(0.4, animations: {
                // This causes first view to fade in and second view to fade out
                self.moveUpBillSection()
            })
            
            UIView.animateWithDuration(0.8, animations: {
                self.tipChooser.alpha = 1
                self.totalCurrencyLabel.alpha = 1
                self.totalAmountLabel.alpha = 1
                self.separator.alpha = 1
                self.tipLabel.alpha = 1
                self.tipAmountLabel.alpha = 1
            })
        }
        Settings.cleanStart = false
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        
        var tipPercentage = tipPercentages[tipChooser.selectedSegmentIndex]
        
        billAmount = billField.text._bridgeToObjectiveC().doubleValue
        tipAmount = billAmount * tipPercentage
        totalAmount = billAmount + tipAmount
        
        tipAmountLabel.text = formatCurrency(tipAmount, withSymbol: true)
        totalAmountLabel.text = formatCurrency(totalAmount, withSymbol: false)
        Settings.lastBillAmount = billField.text
        Settings.lastTipIndex = tipChooser.selectedSegmentIndex
        
        tipLabel.text = tipChooser.titleForSegmentAtIndex(tipChooser.selectedSegmentIndex) + " TIP"
 
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func moveUpBillSection() {
        var origin1 = self.billCurrencyLabel.frame.origin
        var size1 = CGSize(width: self.billCurrencyLabel.frame.width, height: 140)
        
        var origin2 = self.billField.frame.origin
        var size2 = CGSize(width: self.billField.frame.width, height: 140)
        
        self.billCurrencyLabel.frame = CGRect(origin: origin1,size: size1)
        
        self.billField.frame = CGRect(origin: origin2,size: size2)
    }
    
    func formatCurrency(amount :Double, withSymbol :Bool) -> String {
        
        var formatter = NSNumberFormatter()
        formatter.locale = NSLocale.currentLocale()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        
        if (withSymbol == false) {
            formatter.currencySymbol = ""
        }
        
        return formatter.stringFromNumber(amount)
    }
    
    func currencySymbol() -> String {
        var formatter = NSNumberFormatter()
        formatter.locale = NSLocale.currentLocale()
        return formatter.currencySymbol
    }
    
    func changeColor() {
        //Light theme
        if (Settings.theme == 0) {
            mainView.backgroundColor = lightBackgroundColor
            billCurrencyLabel.textColor = darkTextColor
            billField.textColor = darkTextColor
            tipLabel.textColor = darkTextColor
            tipAmountLabel.textColor = darkTextColor
            separator.backgroundColor = darkTextColor
            totalCurrencyLabel.textColor = darkTextColor
            totalAmountLabel.textColor = darkTextColor
            self.navigationController.navigationBar.barTintColor = lightBackgroundColor
            self.navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: darkTextColor] as NSDictionary
            billField.keyboardAppearance = UIKeyboardAppearance.Light
        }
        else {
            mainView.backgroundColor = darkBackgroundColor
            billCurrencyLabel.textColor = lightTextColor
            billField.textColor = lightTextColor
            tipLabel.textColor = lightTextColor
            tipAmountLabel.textColor = lightTextColor
            separator.backgroundColor = lightTextColor
            totalCurrencyLabel.textColor = lightTextColor
            totalAmountLabel.textColor = lightTextColor
            self.navigationController.navigationBar.barTintColor = darkBackgroundColor
            self.navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: lightTextColor] as NSDictionary
            billField.keyboardAppearance = UIKeyboardAppearance.Dark
            
            
            //UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.BlackOpaque, animated: false);

        }
    }


}
