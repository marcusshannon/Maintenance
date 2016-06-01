//
//  WorkerViewController.swift
//  Maintenance
//
//  Created by Marcus Shannon on 4/25/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit

class WorkerViewController: UIViewController {

    var model: DataModel!
    
    var firstNameSet: Bool = false
    var lastNameSet: Bool = false
    
    @IBOutlet weak var firstNameInput: UITextField!
    
    @IBOutlet weak var lastNameInput: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func firstNameChanged(sender: UITextField) {
        if sender.text != nil {
            firstNameSet = true
        }
        if firstNameSet && lastNameSet {
            saveButton.enabled = true
        }
    }

    @IBAction func lastNameChanged(sender: UITextField) {
        if sender.text != nil {
            lastNameSet = true
        }
        if firstNameSet && lastNameSet {
            saveButton.enabled = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        saveButton.enabled = false
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
        //self.model.currentStage.currentStage = Stage.Menu.rawValue
        self.model.save()
        let dest = segue.destinationViewController as! MenuViewController
        dest.model = self.model
    }
}
