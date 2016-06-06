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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let model: DataModel = Model()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if model.worker.firstName?.characters.count > 0 && model.worker.lastName?.characters.count > 0 {
            let dest = storyBoard.instantiateViewControllerWithIdentifier("Menu") as! MenuViewController
            dest.model = model
            self.pushViewController(dest, animated: false)
        } else {
            let dest = storyBoard.instantiateViewControllerWithIdentifier("Worker") as! WorkerViewController
            dest.model = model
            self.pushViewController(dest, animated: false)
        }
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
