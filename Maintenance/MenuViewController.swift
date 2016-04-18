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
    
    var serviceRequest: ServiceRequest?
    var moc: NSManagedObjectContext!
    
    func serviceRequestPipe() {
        let serviceRequestFetch = NSFetchRequest(entityName: "ServiceRequest")
        do {
            let toBeDeleted = try self.moc.executeFetchRequest(serviceRequestFetch) as! [ServiceRequest]
            if toBeDeleted.count > 0 {
                self.moc.deleteObject(toBeDeleted.first!)
            }
        } catch {
            fatalError()
        }
        self.serviceRequest = NSEntityDescription.insertNewObjectForEntityForName("ServiceRequest", inManagedObjectContext: moc) as? ServiceRequest
        do {
            try self.moc.save()
        } catch {
            fatalError()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.moc = appDelegate.dataController.managedObjectContext
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        serviceRequestPipe()
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let dest = segue.destinationViewController as! ServiceRequestNumberInputViewController
        dest.serviceRequest = self.serviceRequest
    }
}
