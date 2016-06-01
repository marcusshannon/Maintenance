//
//  ServiceRequestNumberInputViewController.swift
//  Maintenance
//
//  Created by Marcus Shannon on 4/16/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit
import CoreData

class ServiceRequestNumberInputViewController: UIViewController {
    
    var model: DataModel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var serviceRequestInput: UITextField!
    
    @IBAction func serviceRequestNumberChanged(sender: UITextField) {
        if sender.text != nil {
            self.nextButton.enabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        self.model.serviceRequest.srNumber = serviceRequestInput.text!
        self.model.save()
        let dest = segue.destinationViewController as! LocationViewController
        dest.model = self.model
    }
}
