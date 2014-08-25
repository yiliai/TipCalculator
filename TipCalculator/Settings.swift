//
//  Settings.swift
//  TipCalculator
//
//  Created by Yili Aiwazian on 8/23/14.
//  Copyright (c) 2014 Yili Aiwazian. All rights reserved.
//

import Foundation
import UIKit

let saveBillFor :NSTimeInterval = -(10*60)
let tipPercentages = [0.18, 0.2, 0.22]

let darkBackgroundColor = UIColorFromRGB(0x444444)
let lightBackgroundColor = UIColor.whiteColor()
let darkTextColor = UIColor.blackColor()
let lightTextColor = UIColor.whiteColor()
let tintColor = UIColorFromRGB(0xacd373)

struct Settings {
    static var defaultIndex = 0
    static var lastBillAmount = String()
    static var lastTipIndex = 0
    static var cleanStart = true
    static var theme = 0
     
}

func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

