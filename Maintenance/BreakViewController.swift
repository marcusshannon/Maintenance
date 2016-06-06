//
//  BreakViewController.swift
//  Maintenance
//
//  Created by Marcus Shannon on 6/4/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit

class BreakViewController: UIViewController {

    var model: DataModel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var endButton: UIButton!
    
    @IBAction func startBreak(sender: AnyObject) {
        let currentTime = NSDate()
        self.model.serviceRequest.travelStart = currentTime
        self.model.serviceRequest.travelEnd = currentTime
        self.model.serviceRequest.taskStart = currentTime
        self.model.save()
        startButton.enabled = false
        let formatter = NSDateFormatter()
        formatter.dateFormat = "hh:mm a"
        startButton.setTitle(formatter.stringFromDate(currentTime), forState: UIControlState.Disabled)
        endButton.enabled = true
        endButton.backgroundColor = UIColor(red: 248/255, green: 147/255, blue: 31/255, alpha: 1.0)

    }
    
    @IBAction func endBreak(sender: AnyObject) {
        let currentTime = NSDate()
        self.model.serviceRequest.srNumber = "Lunch / Break"
        self.model.serviceRequest.taskEnd = currentTime
        self.model.serviceRequest.taskDescription = "Break / Lunch"
        self.model.serviceRequest.inProgress = false
        self.model.save()
    }
    
    func post() {
        let serviceRequest = self.model.serviceRequest
        let worker = self.model.worker
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        
        let data = ["firstName": worker.firstName!,
                    "lastName": worker.lastName!,
                    "serviceRequestNumber": serviceRequest.srNumber!,
                    "location": serviceRequest.location!,
                    "taskDescription": serviceRequest.taskDescription!,
                    "travelStart": formatter.stringFromDate(serviceRequest.travelStart!),
                    "travelEnd": formatter.stringFromDate(serviceRequest.travelEnd!),
                    "taskStart": formatter.stringFromDate(serviceRequest.taskStart!),
                    "taskEnd": formatter.stringFromDate(serviceRequest.taskEnd!),
                    "workInProgress": serviceRequest.inProgress!]
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.1.110:4000")!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions(rawValue: 0))
        }
        catch {
            fatalError()
        }
        
        let session = NSURLSession.sharedSession()
        //let task = session.dataTaskWithRequest(request)
        
        session.dataTaskWithRequest(request) { (data, response, error) in
//            let httpResponse = response as! NSHTTPURLResponse
//            if httpResponse.statusCode == 200 {
//                print("success")
//            }
//            else {
//                print("fail")
//            }
        }.resume()
        
        
        
//        session.dataTaskWithRequest(request) {
//            data, response, error in
//            print("doing th is shit")
//            let httpResponse = response as! NSHTTPURLResponse
//            print(httpResponse.statusCode)
//            if httpResponse.statusCode == 200 {
//                print("successsssss")
//            }
//        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        endButton.enabled = false
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
        post()
        let dest = segue.destinationViewController as! MenuViewController
        dest.model = self.model
    }
}
