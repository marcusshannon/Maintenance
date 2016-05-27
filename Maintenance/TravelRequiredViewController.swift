//
//  TravelRequiredViewController.swift
//  Maintenance
//
//  Created by Marcus Shannon on 4/16/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit

class TravelRequiredViewController: UIViewController {
    
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
        if (segue.identifier != nil) {
            let dest = segue.destinationViewController as! TravelTimeViewController
            dest.model = self.model
        }
        else {
            let dest = segue.destinationViewController as! DetailsViewController
            dest.model = self.model
            let serviceRequest = self.model.getObject(Entity.ServiceRequest) as! ServiceRequest
            serviceRequest.travelStart = NSDate()
            serviceRequest.travelEnd = NSDate()
            serviceRequest.taskStart = NSDate()
            self.model.save()
        }
    }
}
