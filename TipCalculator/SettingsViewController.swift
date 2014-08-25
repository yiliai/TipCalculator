//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Yili Aiwazian on 8/23/14.
//  Copyright (c) 2014 Yili Aiwazian. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var settingsView: UIView!
    @IBOutlet weak var tipDefaultPicker: UIPickerView!
    @IBOutlet weak var themeChooser: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //println("view will appear")
        tipDefaultPicker.delegate = self
        tipDefaultPicker.dataSource = self
        tipDefaultPicker.selectRow(Settings.defaultIndex, inComponent: 0, animated: false)

        themeChooser.selectedSegmentIndex = Settings.theme
        changeColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //println("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //println("view will disappear")
        
        Settings.defaultIndex = tipDefaultPicker.selectedRowInComponent(0)
        Settings.theme = themeChooser.selectedSegmentIndex
        //Settings.lastTipIndex = Settings.defaultIndex

        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(Settings.defaultIndex, forKey: "DefaultTipIndex")
        defaults.setInteger(Settings.theme, forKey: "ThemeColor")
        
        defaults.synchronize()
    }
    
    @IBAction func onTapSave(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onThemeChange(sender: AnyObject) {
        println ("theme change")
        changeColor()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func changeColor() {
        //Light theme
        if (themeChooser.selectedSegmentIndex == 0) {
            settingsView.backgroundColor = lightBackgroundColor
            tipLabel.textColor = darkTextColor
            themeLabel.textColor = darkTextColor
            //tipDefaultPicker.
        }
        else {
            settingsView.backgroundColor = darkBackgroundColor
            tipLabel.textColor = lightTextColor
            themeLabel.textColor = lightTextColor
        }
        tipDefaultPicker.reloadAllComponents()
    }
}


extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) ->   Int {
        return tipPercentages.count
    }
}
    
extension SettingsViewController: UIPickerViewDelegate {
        
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {

        var amount = String (format: "%.0f%%", tipPercentages[row]*100)
        return amount
    }
    
    func pickerView(pickerView: UIPickerView!, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView! {

        var label = UILabel()
        if (themeChooser.selectedSegmentIndex == 0) {
            label.textColor = darkTextColor
        }
        else {
            label.textColor = lightTextColor
        }

        label.text = String (format: "%.0f%%", tipPercentages[row]*100)
        label.textAlignment = NSTextAlignment.Center

        return label
    }
    
   func pickerView(pickerView: UIPickerView!,
            didSelectRow row: Int,
             inComponent component: Int) {

        Settings.lastTipIndex = row
    }
}
