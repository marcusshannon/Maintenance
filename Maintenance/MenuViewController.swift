//
//  MenuViewController.swift
//  Maintenance
//
//  Created by Marcus Shannon on 4/10/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit
import CoreData

class MenuViewController: UIViewController {
    
    let moc = DataController().managedObjectContext
    var serviceRequest: ServiceRequest?
    
    @IBAction func serviceRequest(sender: AnyObject) {
        let serviceRequestFetch = NSFetchRequest(entityName: "ServiceRequest")
        
        do {
            let fetchedServiceRequest = try self.moc.executeFetchRequest(serviceRequestFetch) as! [ServiceRequest]
            if fetchedServiceRequest.count == 0 {
                serviceRequest = NSEntityDescription.insertNewObjectForEntityForName("ServiceRequest", inManagedObjectContext: self.moc) as! ServiceRequest
                try moc.save()
            }
        } catch {
            fatalError("Failed to fetch Service Request: \(error)")
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
        segue.destinationViewController
    }
 

}
