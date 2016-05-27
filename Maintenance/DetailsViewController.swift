//
//  DetailsViewController.swift
//  Maintenance
//
//  Created by Marcus Shannon on 4/17/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UINavigationControllerDelegate {
    
    var model: DataModel!

    @IBAction func serverDetails(sender: AnyObject) {
        serviceRequest.taskDescription = descriptionBox.text
        serviceRequest.taskEnd = NSDate()
        
        do {
            try serviceRequest.managedObjectContext?.save()
        } catch {
            
        }
        
        let alert = UIAlertView()
        alert.title = "Seding to server:"
        alert.message = "Task Description: \(serviceRequest.taskDescription!) \n SR #: \(serviceRequest.srNumber!) \n Location: \(serviceRequest.location!) \n Task Start: \(serviceRequest.taskStart!) \n Task End: \(serviceRequest.taskEnd!) \n Travel Start: \(serviceRequest.travelStart!) \n Travel End: \(serviceRequest.travelEnd!)"
        alert.addButtonWithTitle("Ok")
        alert.show()

    }
    
    
    @IBOutlet weak var startTime: UILabel!
    
    @IBOutlet weak var descriptionBox: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionBox.layer.borderColor = UIColor.orangeColor().CGColor
        descriptionBox.layer.borderWidth = 1
        descriptionBox.layer.cornerRadius = 5
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        formatter.dateFormat = "hh:mm a"
        
        startTime.text = "Start time: " + formatter.stringFromDate(serviceRequest.taskStart!)
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
