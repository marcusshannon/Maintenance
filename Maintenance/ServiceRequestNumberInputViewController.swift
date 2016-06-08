//
//  ServiceRequestNumberInputViewController.swift
//  Maintenance
//
//  Created by Marcus Shannon on 4/16/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit
import CoreData

class ServiceRequestNumberInputViewController: UIViewController, UITextFieldDelegate {
    
    var model: DataModel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var serviceRequestInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nextButton.enabled = false
        serviceRequestInput.delegate = self
        nextButton.layer.cornerRadius = 5.0
        serviceRequestInput.layer.borderColor = UIColor(red: 248/255, green: 147/255, blue: 31/255, alpha: 1.0).CGColor
        serviceRequestInput.layer.borderWidth = 1.0
        serviceRequestInput.layer.cornerRadius = 5.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField.text!.characters.count + string.characters.count - range.length > 0 {
            nextButton.enabled = true
            nextButton.backgroundColor = UIColor(red: 248/255, green: 147/255, blue: 31/255, alpha: 1.0)
        }
        else {
            nextButton.enabled = false
            nextButton.backgroundColor = UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 1.0)
        }
        return true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        self.model.serviceRequest.srNumber = serviceRequestInput.text!
        self.model.save()
        let dest = segue.destinationViewController as! LocationViewController
        dest.model = self.model
    }
}
