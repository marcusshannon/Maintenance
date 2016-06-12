//
//  GoogleViewController.swift
//  Maintenance
//
//  Created by Marcus Shannon on 6/10/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit
import GTMOAuth2
import GoogleAPIClientForREST


class GoogleViewController: UIViewController {
    
    private let kKeychainItemName = "Google Sheets API"
    private let scope = "https://www.googleapis.com/auth/spreadsheets"
    let kClientID = "349355649504-509s16i41hangum1u21j64gmjpat2v0d.apps.googleusercontent.com"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        presentViewController(createAuthController(), animated: true, completion: nil)
    }
    
    private func createAuthController() -> GTMOAuth2ViewControllerTouch {
        return GTMOAuth2ViewControllerTouch(scope: scope, clientID: kClientID, clientSecret: nil, keychainItemName: kKeychainItemName, delegate: self, finishedSelector: #selector(GoogleViewController.viewController(_:finishedWithAuth:error:))
        )
    }
    
    // Handle completion of the authorization process, and update the Google Sheets API
    // with the new credentials.
    func viewController(vc : UIViewController, finishedWithAuth authResult : GTMOAuth2Authentication, error : NSError?) {
        //dismissViewControllerAnimated(true, completion: nil)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let dest = storyBoard.instantiateViewControllerWithIdentifier("Controller") as! NavigationController
        self.presentViewController(dest, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
