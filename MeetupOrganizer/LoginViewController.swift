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


let kCloseSafariViewControllerNotification = "kCloseSafariViewControllerNotification"


class LoginViewController: UIViewController, SFSafariViewControllerDelegate {
    
    var safariVC: SFSafariViewController?
    
    var meetupRouter = MeetupRouter()


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // prepare the request for getting the authorization code, and to load it through a safariVC
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
    
//        var authorizationURL = "\(AuthorizationEndpoint)?"
//        authorizationURL += "response_type=\(ResponseType)&"
//        authorizationURL += "client_id=\(OAuthKey)&"
//        authorizationURL += "redirect_uri=\(RedirectUri)&"
//        authorizationURL += "state=\(State)&"
//        authorizationURL += "scope=\(Scope)"
        
        
        
//        let request = URLRequest(url: URL(string: authorizationURL)!)
//
//        let view = UIWebView(frame: self.view.bounds)
//        self.view.addSubview(view)
//        
//        view.loadRequest(request)

        
        let oauthswift = OAuth2Swift(
            consumerKey:    OAuthKey,
            consumerSecret: OAuthSecret,
            authorizeUrl:   AuthorizationEndpoint,
            accessTokenUrl:  AccessTokenEndpoint,
            responseType:   ResponseType
        )
        
        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthswift)

        
        // callback url: http://oauthswift.herokuapp.com/callback/linkedin2

        let _ = oauthswift.authorize(
            withCallbackURL: URL(string: RedirectUri)!,
            scope: Scope, state: State,
            success: { credential, response, parameters in
                
                print("\n credential.oauthToken is : \(credential.oauthToken)")
         
        },
            failure: { error in
                print(error.localizedDescription)
        }
        )
        
 
        
//        safariVC = SFSafariViewController(url: URL(string: authorizationURL)!)
//        safariVC!.delegate = self
//        self.present(safariVC!, animated: false, completion: nil)
    }
    
    

    
    func getEvents() {
        
//        oauthswift.client.get("https://api.meetup.com/self/events?&sign=true&photo-host=public&page=20",
//                              success: { response in
//                                let dataString = response.string
//                                print(dataString)
//        },
//                              failure: { error in
//                                print(error)
//        }
//        )
       
    }
        /*
     
        1.  GET AUTHORIZATION CODE
        // on the loginButtonTapped make the request to the meetup server to request authorization code,
        // when user logs in to grant access to their Meetup account to your app, the response should come back in a form of 
        // redirectUri+authorization code + state // example:  meetuporganizer://oauth-callback/meetup?code=3e9b09ff43b9794df210295b634c3594&state=meetup1482513145
     
        // extract the authorization code from the response - oauthswift
        
         
        2.  GET THE ACCESS TOKEN

         // => make request w/the extracted authorization code to get the access token / make a POST request for getting the access token
        We’ll prepare the POST request parameters.
        We’ll initialize and configure a mutable URL request object (NSMutableURLRequest).
        We’ll instantiate a NSURLSession object and perform a data task request. In case we get a proper response, we’ll store the access token to the user defaults dictionary.
        
         1. make post params
         2. convert post params to data 
         3. make a mutable url request with a url from accessTokenEndPoint string
         4. url session 
         5. data task with request -> closure 
         6. in closure response json, get the access token
         7. handle possible error responses from the request 
         8. save acces token to user defaults - ?
         
         
        3. MAKE GET REQUEST FOR SELF/EVENTS FOR THE USER W/THE ACCESS TOKEN 
         
         provide access token, make url, creat request, reguest GET method type, session, task -> closure 
         in closure response, if request is successful, parse Events json data,
         give the parsed events data to eventsTableVC
         go on the main thread and display eventstablevc
     
     let eventsTableVC = EventsTableViewController()
     let navController = UINavigationController(rootViewController: eventsTableVC)
     self.window?.rootViewController?.presentViewController(navController, animated: true, completion: nil)
        
         
         RECAP 
         
         you kick off the OAuth dance by opening the URL in Safari.
         Once the user grants access, this block executes, and you start by extracting the code from the callback URL.
         You then you carry on with step two of the OAuth2 flow: Exchange Code for Token.
         Once you get the token…
         …you attach it to the HTTP header…
         …and finally, make the call to upload the photo to Google Drive.
         
         
         */

    
    
    
    // MARK: - SFSafariViewControllerDelegate
    
    // DO I NEED THIS METHOD? DONE BUTTON AUTOMATICALLY DISMISSES. DO I SEND ANY NOTIFICATIONS ?
    
    // Tells the delegate that the user dismmised the view. Called on "Done" button.
    
//    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
//        controller.dismiss(animated: true, completion: nil)
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
