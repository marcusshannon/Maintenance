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
    
    @IBOutlet weak var firstNameInput: UITextField!
    
    @IBOutlet weak var lastNameInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if model == nil {
            self.model = Model()
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
        let worker = self.model.getObject(Entity.Worker) as! Worker
        worker.firstName = self.firstNameInput.text
        worker.lastName = self.lastNameInput.text
        self.model.save()
    }
    

}
