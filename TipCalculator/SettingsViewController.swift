//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Yili Aiwazian on 8/23/14.
//  Copyright (c) 2014 Yili Aiwazian. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tipDefaultPicker: UIPickerView!
    
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
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //println("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //println("view will disappear")
        
        Settings.defaultIndex = tipDefaultPicker.selectedRowInComponent(0)
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(Settings.defaultIndex, forKey: "DefaultTipIndex")
        defaults.synchronize()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        //println("view did disappear")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsViewController: UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
        
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) ->   Int {
        return Settings.tipPercentages.count
    }
}
    
extension SettingsViewController: UIPickerViewDelegate {
        
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {

        var amount = String (format: "%.0f%%", Settings.tipPercentages[row]*100)
        return amount
    }
}
