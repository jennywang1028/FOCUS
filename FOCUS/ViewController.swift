//
//  ViewController.swift
//  FOCUS
//
//  Created by Jenny Wang on 2/13/16.
//  Copyright © 2016 Jenny Wang. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController , FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var login: UIButton!
    
    @IBAction func loginPressed(sender: AnyObject) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if (FBSDKAccessToken.currentAccessToken() == nil)
        {
            //TODO: change all print statement
            print("Not logged in..")
        }
        else
        {
            //presentViewController(TimerViewController, animated: true, completion: nil)
        }
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        let flm = FBSDKLoginManager()
        flm.logInWithPublishPermissions(["publish_actions"], fromViewController: self, handler:{(result:FBSDKLoginManagerLoginResult!, error:NSError!) -> Void in
            if error != nil {
                //According to Facebook:
                //Errors will rarely occur in the typical login flow because the login dialog
                //presented by Facebook via single sign on will guide the users to resolve any errors.
                
                // Process error
                FBSDKLoginManager().logOut()
            } else if result.isCancelled {
                // Handle cancellations
                FBSDKLoginManager().logOut()
            } else {
                // If you ask for multiple permissions at once, you
                // should check if specific permissions missing
                }
            
        })
        loginButton.center = self.view.center
        loginButton.delegate = self
        self.view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        if error == nil
        {
            print("Login complete.")
        }
        else if result.isCancelled{
            print("user cancelled")
        }
        else{
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        print("User logged out...")
    }
    
    
    
}

