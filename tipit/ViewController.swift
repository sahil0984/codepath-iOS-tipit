//
//  ViewController.swift
//  tipit
//
//  Created by Sahil Arora on 8/20/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var presetTip0: Int = 18
    var presetTip1: Int = 20
    var presetTip2: Int = 25
    
    var billAmount: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        
        println("view loaded")
        var currentDateTime = NSDate()
        println(currentDateTime)
        
        var defaults = NSUserDefaults.standardUserDefaults()

        var lastOpenDateTime = defaults.objectForKey("lastOpenDate") as NSDate
        println(lastOpenDateTime)
        defaults.setValue(currentDateTime, forKey: "lastOpenDate")

        
        var diffTimeInSec = currentDateTime.timeIntervalSinceDate(lastOpenDateTime)
        var diffTimeInMin = diffTimeInSec/60
        println(diffTimeInMin)
        
        if (diffTimeInMin < 10) {
            billAmount = defaults.objectForKey("lastBillAmount") as Double
        } else {
            billAmount = 0.0;
        }
        
        billField.text = NSString(format: "%.2f", billAmount)
        
        
        updateViewControls()
        updateViewFields()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        updateViewFields()
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("view will appear")
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("view did appear")
        
        updateViewControls()
        updateViewFields()
    }
    
    func updateViewControls() {
        var defaults = NSUserDefaults.standardUserDefaults()
        
        if ((defaults.objectForKey("defaultTipIndex")) != nil) {
            presetTip0 = (defaults.objectForKey("presetTip0") as NSString).integerValue
            presetTip1 = (defaults.objectForKey("presetTip1") as NSString).integerValue
            presetTip2 = (defaults.objectForKey("presetTip2") as NSString).integerValue
            tipControl.selectedSegmentIndex = defaults.objectForKey("defaultTipIndex") as Int
        }
        
        tipControl.setTitle(String(presetTip0)+"%", forSegmentAtIndex: 0)
        tipControl.setTitle(String(presetTip1)+"%", forSegmentAtIndex: 1)
        tipControl.setTitle(String(presetTip2)+"%", forSegmentAtIndex: 2)
    }
    
    func updateViewFields() {
        var tipPercentages = [presetTip0, presetTip1, presetTip2]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        //var tipPercentage: Double = Double() * Double(0.01)
        
        var billAmount = (billField.text as NSString).doubleValue
        var tip = billAmount * Double(tipPercentage) * 0.01
        var total = billAmount + tip
        
        //tipLabel.text = "$\(tip)"
        //totalLabel.text = "$\(total)"
        
        //tipLabel.text = String(format: "$%.2f", tip)
        //totalLabel.text = String(format: "$%.2f", total)
        
        tipLabel.text = currencyFormatter.stringFromNumber(tip)
        totalLabel.text = currencyFormatter.stringFromNumber(total)
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(billAmount, forKey: "lastBillAmount")
    }
    
    var currencyFormatter: NSNumberFormatter {
        let formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            return formatter
    }
}

