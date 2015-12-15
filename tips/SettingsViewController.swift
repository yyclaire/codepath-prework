//
//  SettingsViewController.swift
//  tips
//
//  Created by Labuser on 12/15/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()

    @IBOutlet var tipSetting: UISegmentedControl!
    @IBOutlet var themeSetting: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tipSetting.selectedSegmentIndex = defaults.integerForKey("defaultTip")
        themeSetting.selectedSegmentIndex = defaults.integerForKey("selectedTheme")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onChange(sender: AnyObject) {
        defaults.setInteger(tipSetting.selectedSegmentIndex, forKey: "defaultTip")
        defaults.synchronize()
    }

    @IBAction func themeChange(sender: AnyObject) {
        if let selectedTheme = Theme(rawValue: themeSetting.selectedSegmentIndex) {
            ThemeManager.applyTheme(selectedTheme)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
