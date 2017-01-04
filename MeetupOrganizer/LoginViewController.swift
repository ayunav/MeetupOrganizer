//
//  LoginViewController.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 12/19/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit
import SafariServices
import OAuthSwift


let MeetupAccessToken = "meetupAccessToken"

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    var oauthswift: OAuthSwift?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        /*
        // TODO: performsegue for eventstablevc
        // kick off auth dance on eventstableVC
        // when accessToken is received, make request for events,
        // when events response is received, add segm control and tableview programmatically, and populate the tableview with data
         */

        //performSegue(withIdentifier: "ShowEventsTableVCSegueIdentifier", sender: nil)

        /* kick off authorization request, open in SFSafariVC, get authorization code with the redirectUri, extract code, and request for the access token */
        
        let oauthswift = OAuth2Swift(
            consumerKey:    OAuthKey,
            consumerSecret: OAuthSecret,
            authorizeUrl:   AuthorizationEndpoint,
            accessTokenUrl:  AccessTokenEndpoint,
            responseType:   ResponseType
        )
        
        
        /* auth config */
        self.oauthswift = oauthswift
        
        /* opens SFSafariVC to request redirectUri */
        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthswift)
        
        
        /* callBackURL sends a notification from the app delegate when the redirectUri is received, dismisses, safariVC to open back in the app by handling the url (redirectUri) in the loginVC
           get access token from the redirectUri */
        let _ = oauthswift.authorize(
            withCallbackURL: URL(string: RedirectUri)!,
            scope: Scope, state: State,
            success: { credential, response, parameters in

                UserDefaults.standard.set(credential.oauthToken, forKey: MeetupAccessToken)
                UserDefaults.standard.synchronize()
                
                OperationQueue.main.addOperation {
                    self.performSegue(withIdentifier: "ShowEventsTableVCSegueIdentifier", sender: nil)

                }
        },
            failure: { error in
                print(error.localizedDescription)
        }
        )
    }
  
}
