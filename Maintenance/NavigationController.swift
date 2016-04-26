//
//  NavigationController.swift
//  Maintenance
//
//  Created by Marcus Shannon on 4/16/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit
import CoreData

class NavigationController: UINavigationController {

    var worker: Worker?
    var moc: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.moc = appDelegate.dataController.managedObjectContext
        let workerFetch = NSFetchRequest(entityName: "Worker")
        do {
            let fetchedWorkers = try self.moc.executeFetchRequest(workerFetch) as! [Worker]
            if fetchedWorkers.count > 0 {
                self.pushViewController(storyBoard.instantiateViewControllerWithIdentifier("Menu"), animated: false)
            }
            else {
                self.worker = NSEntityDescription.insertNewObjectForEntityForName("Worker", inManagedObjectContext: moc) as? Worker
                let dest = storyBoard.instantiateViewControllerWithIdentifier("Worker") as! WorkerViewController
                dest.worker = self.worker!
                self.pushViewController(dest, animated: false)
            }
        } catch {
            fatalError()
        }
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
        
    }
    

}
