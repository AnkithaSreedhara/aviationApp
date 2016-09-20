//
//  ViewController.swift
//  aviationApp
//
//  Created by Anki on 14/09/16.
//  Copyright © 2016 Anki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet var dateField: UITextField!
    @IBOutlet var fromFirld: UITextField!
    @IBOutlet var toField: UITextField!
    @IBOutlet var takeOffTimeField: UITextField!
    @IBOutlet var landingTimeField: UITextField!
    @IBOutlet var registrationField: UITextField!
    @IBOutlet var aircraftTypeField: UITextField!
    @IBOutlet var nameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "keyboardOnScreen:", name: UIKeyboardDidShowNotification, object: nil)
        center.addObserver(self, selector: "keyboardOffScreen:", name: UIKeyboardDidHideNotification, object: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "doneEditing")
        dateField.delegate = self
        fromFirld.delegate = self
        toField.delegate = self
        takeOffTimeField.delegate = self
        landingTimeField.delegate = self
        registrationField.delegate = self
        aircraftTypeField.delegate = self
        nameField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    func textFieldDidEndEditing(textField: UITextField) {
        view.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    func doneEditing(){
        let stringset1 = dateField.text! + "," + fromFirld.text! + "," + takeOffTimeField.text!
         let stringset2 = "," + toField.text! + "," + landingTimeField.text! + ","
        let stringset3 = aircraftTypeField.text! + "," + registrationField.text! + ","
        let stringset4 = stringset3 + takeOffTimeField.text! + "," + nameField.text!
        
        let tagflag = ["data" : stringset1 + stringset2 + stringset4]
        NSNotificationCenter.defaultCenter().postNotificationName("datasend", object: nil, userInfo:tagflag)
        self.navigationController?.popViewControllerAnimated(true)
    }
    var datePickerView  : UIDatePicker = UIDatePicker()
    @IBAction func toTimePickerView(sender: UITextField) {
        // Creates the toolbar
        let toolBar = UIToolbar()
        toolBar.barStyle = .Black
        toolBar.translucent = true
        toolBar.backgroundColor = UIColor.whiteColor()
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.sizeToFit()
        
        // Adds the buttons
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "onTimedoneClick(_:)")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "onTimecancelClick(_:)")
        toolBar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        inputView.layer.backgroundColor = UIColor.clearColor().CGColor
        datePickerView.frame = CGRectMake(0, 0, self.view.frame.width, 240)
        
        //set Time mode
        datePickerView.datePickerMode = UIDatePickerMode.Time
        inputView.addSubview(datePickerView)
        sender.inputView = inputView
        sender.inputAccessoryView = toolBar
    }
    @IBAction func onTimePicker(sender: UITextField) {
        // Creates the toolbar
        let toolBar = UIToolbar()
        toolBar.barStyle = .Black
        toolBar.translucent = true
        toolBar.backgroundColor = UIColor.whiteColor()
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.sizeToFit()
        
        // Adds the buttons
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "onTimedoneClick(_:)")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "onTimecancelClick(_:)")
        toolBar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        inputView.layer.backgroundColor = UIColor.clearColor().CGColor
        datePickerView.frame = CGRectMake(0, 0, self.view.frame.width, 240)
        
        //set Time mode
        datePickerView.datePickerMode = UIDatePickerMode.Time
        inputView.addSubview(datePickerView)
        sender.inputView = inputView
        sender.inputAccessoryView = toolBar
    }
    func onTimedoneClick(sender: UITextField) {
        let dateFormatter = NSDateFormatter()
        datePickerView.datePickerMode = UIDatePickerMode.Time
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        sender.text = dateFormatter.stringFromDate(datePickerView.date)
        sender.resignFirstResponder()
    }
    
    func onTimecancelClick(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func datepickerfordate(sender: UITextField) {
        sender.resignFirstResponder()
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .Black
        toolBar.translucent = true
        toolBar.backgroundColor = UIColor.whiteColor()
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.sizeToFit()
        
        // Adds the buttons
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action:  "datedoneClick")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action:  "datecancelClick")
        toolBar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        //Create the view
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        inputView.layer.backgroundColor = UIColor.clearColor().CGColor
        datePickerView.frame = CGRectMake(0, 0, self.view.frame.width, 240)
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        sender.inputView = inputView
        sender.inputAccessoryView = toolBar
        
    }
    func datedoneClick(sender:UITextField) {
        let dateFormatter = NSDateFormatter()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        sender.text = dateFormatter.stringFromDate(datePickerView.date)
        sender.resignFirstResponder()
    }
    
    func datecancelClick(sender:UITextField) {
        sender.resignFirstResponder()
    }
    func keyboardOnScreen(notification: NSNotification){
        let info: NSDictionary  = notification.userInfo!
        let kbSize = info.valueForKey(UIKeyboardFrameEndUserInfoKey)?.CGRectValue.size
        let contentInsets:UIEdgeInsets  = UIEdgeInsetsMake(0.0, 0.0, kbSize!.height, 0.0)
        scroll.contentInset = contentInsets
        scroll.scrollIndicatorInsets = contentInsets
        var aRect: CGRect = self.view.frame
        aRect.size.height -= kbSize!.height
    }
    
    func keyboardOffScreen(notification: NSNotification){
        let contentInsets:UIEdgeInsets = UIEdgeInsetsZero
        scroll.contentInset = contentInsets
        scroll.scrollIndicatorInsets = contentInsets
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

