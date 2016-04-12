//
//  SRInputViewController.swift
//  Maintenance
//
//  Created by Marcus Shannon on 4/10/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit
import CoreData

class SRInputViewController: UIViewController {
    
    @IBOutlet weak var serviceRequestInput: UITextField!
    
    let moc = DataController().managedObjectContext

    @IBAction func inputSR(sender: AnyObject?) {
        let serviceRequestFetch = NSFetchRequest(entityName: "ServiceRequest")
        
        do {
            let error = NSErrorPointer()
            moc.countForFetchRequest(serviceRequestFetch, error: error)
            let fetchedServiceRequest = try self.moc.executeFetchRequest(serviceRequestFetch) as! [ServiceRequest]
            print(fetchedServiceRequest.count)
            fetchedServiceRequest[0].srNumber = Int(serviceRequestInput.text!)
            try moc.save()
        } catch {
            fatalError("Failed to fetch service request: \(error)")
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
