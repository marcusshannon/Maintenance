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
    
    var model: DataModel!

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
        
        if segue.identifier! == "Service Request" {
            let dest = segue.destinationViewController as! ServiceRequestNumberInputViewController
            dest.model = self.model
        }
        if segue.identifier == "Break" {
            let dest = segue.destinationViewController as! BreakViewController
            dest.model = self.model
        }
        if segue.identifier == "Worker" {
            let dest = segue.destinationViewController as! WorkerViewController
            dest.model = self.model
        }
    }
}
