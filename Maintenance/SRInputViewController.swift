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
    
    var moc: NSManagedObjectContext!
    var data: ServiceRequest!
    var test = "testmothafucka"

    @IBAction func inputSR(sender: AnyObject?) {
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        data.srNumber = 55
        print(data.srNumber)

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
