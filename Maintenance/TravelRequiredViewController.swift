//
//  TravelRequiredViewController.swift
//  Maintenance
//
//  Created by Marcus Shannon on 4/16/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit

class TravelRequiredViewController: UIViewController {
    
    var serviceRequest: ServiceRequest!
    
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
        if (segue.identifier != nil) {
            let dest = segue.destinationViewController as! TravelTimeViewController
            dest.serviceRequest = self.serviceRequest
        }
        else {
            let dest = segue.destinationViewController as! DetailsViewController
            dest.serviceRequest = self.serviceRequest
            serviceRequest.travelStart = NSDate()
            serviceRequest.travelEnd = NSDate()
            serviceRequest.taskStart = NSDate()
            do {
                try serviceRequest.managedObjectContext!.save()
            } catch {
                fatalError()
            }

        }
    }
}
