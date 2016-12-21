//
//  LoginViewController.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 12/19/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        startAuthorization()
    
    }

    
    func startAuthorization() {
        
        var authorizationURL = "\(AuthorizationEndpoint)?"
        authorizationURL += "response_type=\(ResponseType)&"
        authorizationURL += "client_id=\(OAuthKey)&"
        authorizationURL += "redirect_uri=\(RedirectURI)&"
        authorizationURL += "state=\(State)&"
        authorizationURL += "scope=\(Scope)"
        
        print(authorizationURL)

        let safariVC = SFSafariViewController(url: URL(string: authorizationURL)!)
        self.present(safariVC, animated: true, completion: nil)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
