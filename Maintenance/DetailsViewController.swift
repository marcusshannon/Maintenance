//
//  DetailsViewController.swift
//  Maintenance
//
//  Created by Marcus Shannon on 4/17/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit
import GTMOAuth2
import GoogleAPIClientForREST

class DetailsViewController: UIViewController, UINavigationControllerDelegate {
    
    var model: DataModel!
    let kKeychainItemName = "Google Sheets API"
    let kClientID = "520986608923-k8rng83ktia0tufr8okh2fvosh2orroq.apps.googleusercontent.com"
    let service = GTLRService()

    
    @IBOutlet weak var startTime: UILabel!
    
    @IBOutlet weak var descriptionBox: UITextView!
    
    @IBAction func workInProgress(sender: AnyObject) {
        self.model.serviceRequest.taskDescription = descriptionBox.text
        self.model.serviceRequest.taskEnd = NSDate()
        self.model.serviceRequest.inProgress = true
        self.model.save()
        self.post()
    }
    @IBAction func completeTask(sender: AnyObject) {
        self.model.serviceRequest.taskDescription = descriptionBox.text
        self.model.serviceRequest.taskEnd = NSDate()
        self.model.serviceRequest.inProgress = false
        self.model.save()
        self.post()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let auth = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychainForName(kKeychainItemName, clientID: kClientID, clientSecret: nil)
        service.authorizer = auth
        service.rootURLString = "https://sheets.googleapis.com/"

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
        
        let dimensionRequest = GTLRSheets_InsertDimensionRequest()
        dimensionRequest.inheritFromBefore = false
        let dimensionRange = GTLRSheets_DimensionRange()
        dimensionRange.dimension = "ROWS"
        dimensionRange.startIndex = 0
        dimensionRange.endIndex = 1
        dimensionRange.sheetId = 0
        dimensionRequest.range = dimensionRange
        
        let request = GTLRSheets_Request()
        request.insertDimension = dimensionRequest
        
        let batch = GTLRSheets_BatchUpdateSpreadsheetRequest()
        batch.requests = [request]
        
        let insertQuery = GTLRSheetsQuery_SpreadsheetsBatchUpdate.queryWithObject(batch, spreadsheetId: "1i_p3UkMb09BcgOdmyILyWcgoHZ5sJhx4sJlMdJrHLzI")
        
        
        service.executeQuery(insertQuery, delegate: self, didFinishSelector: #selector(self.addedNewRow(_:finishedWithObject:error:)))
        
    }
        
    func addedNewRow(serviceTicket: GTLRServiceTicket, finishedWithObject: GTLRObject, error: NSError) {
        
        let worker = self.model.worker
        let serviceRequest = self.model.serviceRequest
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "M/d/y H:mm:ss"
        
        
        var travelStart: String?
        var travelEnd: String?
        
        if serviceRequest.travelStart == serviceRequest.travelEnd {
            travelStart = "No Travel"
            travelEnd = "No Travel"
        }
        else {
            travelStart = formatter.stringFromDate(serviceRequest.travelStart!)
            travelEnd = formatter.stringFromDate(serviceRequest.travelEnd!)
        }
        var completed = "Completed"
        if serviceRequest.inProgress == 1 {
            completed = "Work in progress"
        }
        
        let valueRange = GTLRSheets_ValueRange()
        valueRange.majorDimension = "ROWS"
        valueRange.range = "A1"
        valueRange.values = [[worker.firstName!, worker.lastName!, serviceRequest.srNumber!, serviceRequest.location!, travelStart!, travelEnd!, formatter.stringFromDate(serviceRequest.taskStart!), formatter.stringFromDate(serviceRequest.taskEnd!), serviceRequest.taskDescription!, completed]]
        
        
        let query = GTLRSheetsQuery_SpreadsheetsValuesUpdate.queryWithObject(valueRange, spreadsheetId: "1i_p3UkMb09BcgOdmyILyWcgoHZ5sJhx4sJlMdJrHLzI", range: "A1")
        query.valueInputOption = "USER_ENTERED"
        
        service.executeQuery(query, delegate: self, didFinishSelector: #selector(self.addedData(_:finishedWithObject:error:)))
    }
    
    func addedData(serviceTicket: GTLRServiceTicket, finishedWithObject: GTLRObject, error: NSError) {
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let dest = segue.destinationViewController as! MenuViewController
        dest.model = self.model
    }
}
