//
//  LoginViewController.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 12/19/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import OAuthSwift
import SafariServices
import UIKit


let MeetupAccessToken = "meetupAccessToken"

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak fileprivate var loginButton: UIButton!
    
    fileprivate var oauthswift: OAuthSwift?
    

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.object(forKey: MeetupAccessToken) != nil {
            self.performSegue(withIdentifier: "ShowEventsTableVCSegueIdentifier", sender: self)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /* kick off authorization request, open SFSafariVC,
     get authorization code with the redirectUri, 
     extract authorization code, and request access token */
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
   
        /* auth config */
        
        let oauthswift = OAuth2Swift(
            consumerKey   : OAuthKey,
            consumerSecret: OAuthSecret,
            authorizeUrl  : AuthorizationEndpoint,
            accessTokenUrl: AccessTokenEndpoint,
            responseType  : ResponseType
        )

        self.oauthswift = oauthswift
        
        /* opens SFSafariVC to request redirectUri */
        
        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthswift)
        
        /* app delegate sends a notification when the redirectUri is received,
         dismisses safariVC, opens the app back by handleUrl (redirectUri) method,
         passes the redirectUri to the callBackURL closure, which then gets access token from the redirectUri */
        
        let _ = oauthswift.authorize(
            withCallbackURL: URL(string: RedirectUri)!,
                      scope: Scope,
                      state: State,
                    success: { credential, response, parameters in

                        UserDefaults.standard.set(credential.oauthToken, forKey: MeetupAccessToken)
                        UserDefaults.standard.synchronize()
        },
                    failure: { error in
                        print(error.localizedDescription)
        })
    }
    
    
}
