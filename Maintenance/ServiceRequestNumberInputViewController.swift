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
    
    var serviceRequest: ServiceRequest!
    
    @IBOutlet weak var serviceRequestInput: UITextField!
    
    func saveServiceRequestNumber() {
        serviceRequest.srNumber = serviceRequestInput.text!
        do {
            try serviceRequest.managedObjectContext!.save()
        } catch {
            fatalError()
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
        saveServiceRequestNumber()
        let dest = segue.destinationViewController as! LocationViewController
        dest.serviceRequest = self.serviceRequest
        
    }
}
