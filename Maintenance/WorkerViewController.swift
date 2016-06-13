//
//  WorkerViewController.swift
//  Maintenance
//
//  Created by Marcus Shannon on 4/25/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit
import GTMOAuth2

class WorkerViewController: UIViewController, UITextFieldDelegate {

    var model: DataModel!
    var firstNameSet: Bool = false
    var lastNameSet: Bool = false
    private let kKeychainItemName = "Google Sheets API"
    private let scope = "https://www.googleapis.com/auth/spreadsheets"
    let kClientID = "858806897453-pvl1hdkkdpqnn24ofbdon1icsgdojglp.apps.googleusercontent.com"

    
    @IBOutlet weak var firstNameInput: UITextField!
    
    @IBOutlet weak var lastNameInput: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func googleButton(sender: AnyObject) {
        self.presentViewController(createAuthController(), animated: true, completion: nil)
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField === firstNameInput {
            if textField.text!.characters.count + string.characters.count - range.length > 0 {
                firstNameSet = true
            }
            else {
                firstNameSet = false
            }
        }
        if textField === lastNameInput {
            if textField.text!.characters.count + string.characters.count - range.length > 0 {
                lastNameSet = true
            }
            else {
                lastNameSet = false
            }
        }
        if firstNameSet && lastNameSet {
            saveButton.enabled = true
            saveButton.backgroundColor = UIColor(red: 248/255, green: 147/255, blue: 31/255, alpha: 1.0)
        }
        else {
            saveButton.enabled = false
            saveButton.backgroundColor = UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 1.0)
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if firstNameSet && lastNameSet {
            let dest = self.storyboard!.instantiateViewControllerWithIdentifier("Menu") as! MenuViewController
            dest.model = model
            self.navigationController!.pushViewController(dest, animated: true)
        }
        return true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        saveButton.enabled = false
        firstNameInput.delegate = self
        lastNameInput.delegate = self
        if self.model.worker.firstName?.characters.count > 0 && self.model.worker.lastName?.characters.count > 0 {
            firstNameInput.placeholder = self.model.worker.firstName!
            lastNameInput.placeholder = self.model.worker.lastName!
        }
        
        if let auth = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychainForName(kKeychainItemName, clientID: kClientID, clientSecret: nil) {
            print(auth.canAuthorize)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    private func createAuthController() -> GTMOAuth2ViewControllerTouch {
        return GTMOAuth2ViewControllerTouch(scope: scope, clientID: kClientID, clientSecret: nil, keychainItemName: kKeychainItemName, delegate: self, finishedSelector: #selector(GoogleViewController.viewController(_:finishedWithAuth:error:))
        )
    }
    
    func viewController(vc : UIViewController, finishedWithAuth authResult : GTMOAuth2Authentication, error : NSError?) {
        //dismissViewControllerAnimated(true, completion: nil)
        self.dismissViewControllerAnimated(true, completion: nil)
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
        self.model.worker.firstName = firstNameInput.text!
        self.model.worker.lastName = lastNameInput.text!
        self.model.save()
        let dest = segue.destinationViewController as! MenuViewController
        dest.model = self.model
    }
}
