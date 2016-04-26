//
//  DetailsViewController.swift
//  Maintenance
//
//  Created by Marcus Shannon on 4/17/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let alert = UIAlertView()
    
    
    var serviceRequest: ServiceRequest!
    
    @IBOutlet weak var startTime: UILabel!
    
    @IBOutlet weak var descriptionBox: UITextView!
    
    @IBAction func photos() {
        
        let photos = UIImagePickerController()
        photos.sourceType = .SavedPhotosAlbum
        photos.delegate = self
        
        presentViewController(photos, animated: true, completion: nil)
        
    }
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
