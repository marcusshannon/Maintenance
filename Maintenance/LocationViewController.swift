//
//  LocationViewController.swift
//  Maintenance
//
//  Created by Marcus Shannon on 4/16/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var model: DataModel!

    @IBOutlet weak var locationPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationPicker.delegate = self
        locationPicker.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let locations = ["Bayer's Lake", "Clifton", "Thornhill", "Joseph Zatzman", "Almon", "Walker", "White Rose", "Kenmount", "Commonwealth", "Topsal", "Willow", "Upham", "Glendale"]
    
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
        self.model.serviceRequest.location = locations[locationPicker.selectedRowInComponent(0)]
        //self.model.currentStage.currentStage = Stage.Location.rawValue
        self.model.save()
        let dest = segue.destinationViewController as! TravelRequiredViewController
        dest.model = self.model
    }
    

}
