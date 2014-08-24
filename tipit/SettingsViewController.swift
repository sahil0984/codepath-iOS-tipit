//
//  SettingsViewController.swift
//  tipit
//
//  Created by Sahil Arora on 8/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var presetTip0Field: UITextField!
    @IBOutlet weak var presetTip1Field: UITextField!
    @IBOutlet weak var presetTip2Field: UITextField!
    
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var defaults = NSUserDefaults.standardUserDefaults()
        
        if ((defaults.objectForKey("defaultTipIndex")) != nil) {
            presetTip0Field.text = defaults.objectForKey("presetTip0") as String
            presetTip1Field.text = defaults.objectForKey("presetTip1") as String
            presetTip2Field.text = defaults.objectForKey("presetTip2") as String
            defaultTipControl.selectedSegmentIndex = defaults.objectForKey("defaultTipIndex") as Int
        } else {
            presetTip0Field.text = "18"
            presetTip1Field.text = "20"
            presetTip2Field.text = "25"
            defaultTipControl.selectedSegmentIndex = 0
        }
        
        updateSettingsPage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onPresetTip0EditingChanged(sender: AnyObject) {
        if (defaultTipControl.selectedSegmentIndex != 0) {
            defaultTipControl.setTitle(presetTip0Field.text+"%", forSegmentAtIndex: 0)
        }
    }

    @IBAction func onPresetTip1EditingChanged(sender: AnyObject) {
        if (defaultTipControl.selectedSegmentIndex != 1) {
            defaultTipControl.setTitle(presetTip1Field.text+"%", forSegmentAtIndex: 1)
        }
    }
    
    @IBAction func onPresetTip2EditingChanged(sender: AnyObject) {
        if (defaultTipControl.selectedSegmentIndex != 2) {
            defaultTipControl.setTitle(presetTip2Field.text+"%", forSegmentAtIndex: 2)
        }
    }

    @IBAction func onDefaultTipControlChanged(sender: AnyObject) {
        updateSettingsPage()
    }
    
    func updateSettingsPage() {
        defaultTipControl.setTitle(presetTip0Field.text+"%", forSegmentAtIndex: 0)
        defaultTipControl.setTitle(presetTip1Field.text+"%", forSegmentAtIndex: 1)
        defaultTipControl.setTitle(presetTip2Field.text+"%", forSegmentAtIndex: 2)
        
        defaultTipControl.setTitle("default", forSegmentAtIndex: defaultTipControl.selectedSegmentIndex)
        
        //presetTip0Field.backgroundColor = UIColor.blueColor()
        presetTip0Field.borderStyle = UITextBorderStyle.Line
        switch defaultTipControl.selectedSegmentIndex{
        case 0:
            presetTip0Field.borderStyle = UITextBorderStyle.Line
            presetTip1Field.borderStyle = UITextBorderStyle.RoundedRect
            presetTip2Field.borderStyle = UITextBorderStyle.RoundedRect
        case 1:
            presetTip0Field.borderStyle = UITextBorderStyle.RoundedRect
            presetTip1Field.borderStyle = UITextBorderStyle.Line
            presetTip2Field.borderStyle = UITextBorderStyle.RoundedRect
        case 2:
            presetTip0Field.borderStyle = UITextBorderStyle.RoundedRect
            presetTip1Field.borderStyle = UITextBorderStyle.RoundedRect
            presetTip2Field.borderStyle = UITextBorderStyle.Line
        default:
            presetTip0Field.borderStyle = UITextBorderStyle.Line
        }
        
    }

    @IBAction func onDone(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(presetTip0Field.text, forKey: "presetTip0")
        defaults.setObject(presetTip1Field.text, forKey: "presetTip1")
        defaults.setObject(presetTip2Field.text, forKey: "presetTip2")
        defaults.setInteger(defaultTipControl.selectedSegmentIndex, forKey: "defaultTipIndex")
        defaults.synchronize()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}
