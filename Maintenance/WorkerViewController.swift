//
//  WorkerViewController.swift
//  Maintenance
//
//  Created by Marcus Shannon on 4/9/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit
import CoreData

class WorkerViewController: UIViewController {

    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var nameLabel: UILabel!
    
    let moc = DataController().managedObjectContext
    
    @IBAction func saveWorkerName() {
        let workerFetch = NSFetchRequest(entityName: "Worker")
        
        do {
            let fetchedEmployees = try moc.executeFetchRequest(workerFetch) as! [Worker]
            print(fetchedEmployees.count)
            fetchedEmployees[0].firstName = firstNameField.text!
            fetchedEmployees[0].lastName = lastNameField.text!
            do {
                try self.moc.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
            nameLabel.text = fetchedEmployees.first!.firstName! + " " + fetchedEmployees.first!.lastName!
        } catch {
            fatalError("Failed to fetch workers: \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let workerFetch = NSFetchRequest(entityName: "Worker")
        
        do {
            let fetchedEmployees = try moc.executeFetchRequest(workerFetch) as! [Worker]
            //nameLabel.text = fetchedEmployees.first!.firstName! + " " + fetchedEmployees.first!.lastName!
        } catch {
            fatalError("Failed to fetch workers: \(error)")
        }

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
