//
//  Settings.swift
//  TipCalculator
//
//  Created by Yili Aiwazian on 8/23/14.
//  Copyright (c) 2014 Yili Aiwazian. All rights reserved.
//

import Foundation

let saveBillFor :NSTimeInterval = -(10*60)

struct Settings {
    static let tipPercentages = [0.18, 0.2, 0.22]
    static var defaultIndex = 0
    static var billAmount = 0.0
}