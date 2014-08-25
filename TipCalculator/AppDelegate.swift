//
//  AppDelegate.swift
//  TipCalculator
//
//  Created by Yili Aiwazian on 8/21/14.
//  Copyright (c) 2014 Yili Aiwazian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        // Override point for customization after application launch.
        
        self.window?.tintColor = tintColor
        var defaults = NSUserDefaults.standardUserDefaults()
        
        let billLastSet :NSDate? = defaults.objectForKey("BillLastSet") as? NSDate
        let lastTipIndex :Int? = defaults.integerForKey("LastTipIndex")
        let lastBillAmount :String? = defaults.objectForKey("LastBillAmount") as? String
        
        // If the bill's not been saved or if it's longer than the save period (10 min), clear state
        if (billLastSet == nil || billLastSet?.timeIntervalSinceNow <= saveBillFor) {
            Settings.cleanStart = true
        }
        else {
            if (lastBillAmount != nil) {
                Settings.lastBillAmount = lastBillAmount!
            }
            if (lastTipIndex != nil) {
                Settings.lastTipIndex = lastTipIndex!
            }
            Settings.cleanStart = false
        }


        println("LastBillAmount:")
        //var timeInterval = (defaults.objectForKey("BillLastSet") as NSDate).timeIntervalSinceNow
        println(defaults.objectForKey("LastBillAmount"))
        println(defaults.objectForKey("BillLastSet"))
        println(billLastSet?.timeIntervalSinceNow)
        println(billLastSet == nil)
        println(billLastSet?.timeIntervalSinceNow >= -500)
        println(defaults.objectForKey("LastTipIndex"))
        println(Settings.lastTipIndex)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication!) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication!) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        var defaults = NSUserDefaults.standardUserDefaults()
        if (Settings.lastBillAmount != "") {
            defaults.setObject(Settings.lastBillAmount, forKey: "LastBillAmount")
            defaults.setObject(NSDate(), forKey: "BillLastSet")
            defaults.setInteger(Settings.lastTipIndex, forKey: "LastTipIndex")
            defaults.synchronize()
        }
        else {
            defaults.removeObjectForKey("LastBillAmount")
            defaults.removeObjectForKey("BillLastSet")
        }

    }

    func applicationWillEnterForeground(application: UIApplication!) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

    }

    func applicationDidBecomeActive(application: UIApplication!) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication!) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

