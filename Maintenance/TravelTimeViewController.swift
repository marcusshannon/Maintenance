//
//  TravelTimeViewController.swift
//  Maintenance
//
//  Created by Marcus Shannon on 4/16/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit

class TravelTimeViewController: UIViewController {

    var serviceRequest: ServiceRequest!

    @IBAction func startTravelTime() {
        serviceRequest.travelStart = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        formatter.dateFormat = "hh:mm"
        do {
            try serviceRequest.managedObjectContext!.save()
        } catch {
            fatalError()
        }
        travelTimeLabel.text = formatter.stringFromDate(serviceRequest.travelStart!)
    }

    @IBOutlet weak var travelTimeLabel: UILabel!
    
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
        serviceRequest.travelEnd = NSDate()
        print("doing it right")
        serviceRequest.taskStart = NSDate()
        do {
            try serviceRequest.managedObjectContext!.save()
        } catch {
            fatalError()
        }
        let dest = segue.destinationViewController as! DetailsViewController
        dest.serviceRequest = self.serviceRequest
    }
    

}
