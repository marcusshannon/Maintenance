//
//  LocationViewController.swift
//  Maintenance
//
//  Created by Marcus Shannon on 4/16/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var serviceRequest: ServiceRequest!

    @IBOutlet weak var locationPicker: UIPickerView!

    func saveLocation() {
        serviceRequest.location = locations[locationPicker.selectedRowInComponent(0)]
        do {
            try serviceRequest.managedObjectContext!.save()
        } catch {
            fatalError()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationPicker.delegate = self
        locationPicker.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let locations = ["Bayer's Lake", "Clifton", "Thornhill", "Joeseph Zatzman", "Almon"]
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locations.sort()[row]
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        saveLocation()
        let dest = segue.destinationViewController as! TravelRequiredViewController
        dest.serviceRequest = self.serviceRequest
    }
    

}