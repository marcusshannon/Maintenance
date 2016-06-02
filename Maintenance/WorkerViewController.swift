//
//  WorkerViewController.swift
//  Maintenance
//
//  Created by Marcus Shannon on 4/25/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit

class WorkerViewController: UIViewController, UITextFieldDelegate {

    var model: DataModel!
    
    var firstNameSet: Bool = false
    var lastNameSet: Bool = false
    
    @IBOutlet weak var firstNameInput: UITextField!
    
    @IBOutlet weak var lastNameInput: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField === firstNameInput {
            print(string.characters.count)
            if string.characters.count > 0 {
                firstNameSet = true
            }
            else {
                firstNameSet = false
            }
        }
        if textField === lastNameInput {
            print(string.characters.count)
            if string.characters.count > 0 {
                lastNameSet = true
            }
            else {
                lastNameSet = false
            }
        }
        if firstNameSet && lastNameSet {
            saveButton.enabled = true
            saveButton.backgroundColor = UIColor(red: 248/255, green: 147/255, blue: 31/255, alpha: 1.0)
        }
        else {
            saveButton.enabled = false
            saveButton.backgroundColor = UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 1.0)
        }
        return true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        saveButton.enabled = false
        firstNameInput.delegate = self
        lastNameInput.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        self.model.worker.firstName = firstNameInput.text!
        self.model.worker.lastName = lastNameInput.text!
        self.model.save()
        let dest = segue.destinationViewController as! MenuViewController
        dest.model = self.model
    }
}
