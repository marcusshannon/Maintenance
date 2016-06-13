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
        if (segue.identifier == "travelRequired") {
            self.model.serviceRequest.travelStart = NSDate()
            self.model.save()
            let dest = segue.destinationViewController as! TravelTimeViewController
            dest.model = self.model
            print(dest.model.serviceRequest.srNumber!)
        }
        else {
            let currentTime = NSDate()
            self.model.serviceRequest.travelStart = currentTime
            self.model.serviceRequest.travelEnd = currentTime
            self.model.serviceRequest.taskStart = currentTime
            self.model.save()
            let dest = segue.destinationViewController as! DetailsViewController
            dest.model = self.model
        }
    }
}
