//
//  ViewController.swift
//  tips
//
//  Created by Labuser on 12/15/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let persistTime: Double = 600 // 10 minutes

    @IBOutlet var billField: UITextField!
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        if (defaults.objectForKey("prevDate") != nil) {
            var currentDate = NSDate()
            var prevDate = defaults.objectForKey("prevDate") as! NSDate
            var timeDifference = currentDate.timeIntervalSinceDate(prevDate)
            if (timeDifference < persistTime) {
                billField.text = defaults.objectForKey("prevAmount") as! String
            }
        }
        
        if (defaults.objectForKey("defaultTip") == nil) {
            defaults.setInteger(1, forKey: "defaultTip")
            defaults.synchronize()
        }
        tipControl.selectedSegmentIndex = defaults.integerForKey("defaultTip")
        
        billField.becomeFirstResponder()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "saveData:", name: UIApplicationWillTerminateNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onEditingChanged:", name: UIApplicationWillEnterForegroundNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tipControl.selectedSegmentIndex = defaults.integerForKey("defaultTip")
        onEditingChanged(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPercentages = [0.18, 0.2, 0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = NSString(string: billField.text!).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        
        tipLabel.text = formatter.stringFromNumber(tip)
        totalLabel.text = formatter.stringFromNumber(total)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func saveData(notification: NSNotification) {
        defaults.setObject(billField.text, forKey: "prevAmount")
        defaults.setObject(NSDate(), forKey: "prevDate")
        defaults.synchronize()
    }
}

