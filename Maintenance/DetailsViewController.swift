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
//        let serviceRequest = self.model.serviceRequest
//        let worker = self.model.worker
//        serviceRequest.taskDescription = descriptionBox.text
//        serviceRequest.taskEnd = NSDate()
//        self.model.save()
//        
//        
//        let alert = UIAlertView()
//        alert.title = "Seding to server:"
//        alert.message = "Task Description: \(serviceRequest.taskDescription!) \n SR #: \(serviceRequest.srNumber!) \n Location: \(serviceRequest.location!) \n Task Start: \(serviceRequest.taskStart!) \n Task End: \(serviceRequest.taskEnd!) \n Travel Start: \(serviceRequest.travelStart!) \n Travel End: \(serviceRequest.travelEnd!)\n Worker: \(worker.firstName!) \(worker.lastName!)"
//        alert.addButtonWithTitle("Ok")
//        alert.show()
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
        
        let serviceRequest = self.model.serviceRequest
        
        startTime.text = "Start time: " + formatter.stringFromDate(serviceRequest.taskStart!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func post() {
        print("posting")
        //let serviceRequest = self.model.serviceRequest
        let worker = self.model.worker
        
        let data = ["firstName": worker.firstName!,
                    "lastName": worker.lastName!]
        
//        let data = NSDictionary(
//        data.setValue(worker.lastName!, forKey: "lastName")
//        data.setValue(worker.firstName!, forKey: "firstName")
//        data.setValue(serviceRequest.srNumber!, forKey: "serviceRequestNumber")
//        data.setValue(serviceRequest.location!, forKey: "location")
//        data.setValue(serviceRequest.taskDescription!, forKey: "description")
//        data.setValue(serviceRequest.travelStart, forKey: "travelStart")
//        data.setValue(serviceRequest.travelEnd, forKey: "travelEnd")
//        data.setValue(serviceRequest.taskStart, forKey: "taskStart")
//        data.setValue(serviceRequest.taskEnd, forKey: "taskEnd")
//        data.setValue(serviceRequest.inProgress, forKey: "inProgress")
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.1.110:3000")!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions(rawValue: 0))
        }
        catch {
            print("swag")
            fatalError()
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request)
        task.resume()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        self.post()
    }
}
