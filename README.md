# Meetup Organizer
📲 An iOS app for meetup goers, hosts, and organizers that extends native Meetup app's functionality and lets you upload multiple photos to meetup events. 

## Demo 

![App demo](https://github.com/ayunav/MeetupOrganizer/blob/master/MeetupOrganizerAppDemo.gif)

## How to run 

* Download the source file 
* Open `MeetupOrganizer.xcworkspace` project 
* You will see an error message and the missing `Constants.swift` file in the Project Navigator in the Constants folder. 

![Missing Constants.swift file error](https://github.com/ayunav/MeetupOrganizer/blob/master/Screenshots/Missing_Constants.swift_File.png)

MeetupOrganizer app uses OAuth protocol to let their users login and authenticate with their Meetup account. 
You will need to add `Constants.swift` file to the project with your API key and OAuth Consumer key and secret credentials.
  1. Create new file (cmd + N), name it `Constants`, and add to the project. 
  2. Copy-paste the code from [here](https://github.com/ayunav/MeetupOrganizer/blob/master/GitHubConstants.md), and insert your own API and OAuth keys. 

Build and run.  

You should be able to build and run the project now, but you may encounter a few other possible errors. 

*Missing module error:* 

![Missing module error](https://github.com/ayunav/MeetupOrganizer/blob/master/Screenshots/Missing_module_error.png)

  1. Build (cmd + B) the project. The compiler should stop complaining. 🙄 😂  
  2. If building the project didn't help, run `pod install` in your terminal.  

It shouldn't be a problem, but just in case, if you're missing the image assets in the project, you can download and add them manually from [here](https://github.com/ayunav/MeetupOrganizer/tree/master/MeetupIcons).  


## Acknowledgements

- [CocoaPods NYC Meetup](https://www.meetup.com/CocoaPods-NYC/) - peer lab
- [Alamofire](https://github.com/Alamofire/Alamofire) - HTTP networking library 
- [BSImagePicker](https://github.com/mikaoj/BSImagePicker) - replacement for UIImagePickerController for multiple image selection 
- [NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView) - collection of awesome loading animations
- [OAuthSwift](https://github.com/OAuthSwift/OAuthSwift/) - Swift based OAuth library for iOS and OSX
- [Meetup Logo image](https://a248.e.akamai.net/secure.meetupstatic.com/s/img/786824251364989575000/logo/swarm/m_swarm_630x630.png)


## Resources 

- [iOS Programming: The Big Nerd Ranch Guide by Keur & Hillegass](https://www.bignerdranch.com/we-write/)
- [Building URLs with NSURLComponents and NSURLQueryItems](https://grokswift.com/building-urls/)
- [Meetup API](https://www.meetup.com/meetup_api/) Documentation
- [PHImageManager](https://github.com/FlexMonkey/PHImageManagerTwitterDemo)
- [How to hide your API keys](https://medium.com/@AyunasCode/how-to-hide-your-api-keys-367ef6589949#.deo9jtsae)
- [Best Practices for Opening a Web Page Within an App](http://developer.outbrain.com/ios-best-practices-for-opening-a-web-page-within-an-app/)
- [Meetup oAuth2](https://www.meetup.com/meetup_api/auth/#oauth2) Documentation 
- OAuth 2
  - [Integrating LinkedIn Sign In Using OAuth 2.0](https://www.appcoda.com/linkedin-sign-in/) - AppCoda tutorial    
  - [OAuth 2.0 with Swift (Google Drive example)](https://www.raywenderlich.com/99431/oauth-2-with-swift-tutorial) - raywenderlich.com tutorial 
  - [SFSafariViewController and OAuth – the Instagram example](http://strawberrycode.com/blog/sfsafariviewcontroller-and-oauth-the-instagram-example/)
  - [OAuth2 iOS Example (Reddit)](https://github.com/reddit/reddit/wiki/OAuth2-iOS-Example)
  - [Implicit Flow Example](https://www.oauth.com/oauth2-servers/oauth2-clients/mobile-and-native-apps/)
  - [OAuth2](https://github.com/p2/OAuth2) - OAuth2 frameworks for macOS, iOS and tvOS written in Swift 3.0
  - [Anatomy of an http URL](http://www.webreference.com/html/tutorial2/2.html)
- [DateFormatter all formats](http://nsdateformatter.com/)
- [Flawless UICollectionViews](https://digitalleaves.com/blog/2016/02/flawless-uicollectionviews-and-uitableviews/)
  

### TO-DO

- on navigation to AddPhotosVC, display photos that are already on the server (fetch photos, display in the collection view)
- when uploading new photos, add new photos to the col view (different section? )
- improve response time on fetching upcoming and past events: cache response, add pull to refresh
- add log out/switch account button
- refactor auth code
- refactor image upload 
- handle errors, create user facing alerts 
- add empty states: no upcoming events, no past events
- nit: request access to photos on add photos button tapped, not on vc navigation
- add an app icon 

- upload activity indicator per cell
    - the col view will display selected photos
    - change cells' alpha to opaque
    - add spinning activity indicators indicating upload progress per photo/per cell
    - if there's a problem with upload, display a user facing error message
    - when upload is complete & successful (json response came back), stop & hide activity indicators, change cells' aipha to clear

Not sure about these: 

- ? add waitlist events
- ? deep link to photos at the event, or to the event, or to the meetup group. Play with it.
- ? add caption to uploaded photos: Uploaded by `member name` via Meetup Organizer iOS app by Ayuna Vogel (include link?)
- ? two sections for the images that are already on the server, and for the newly uploaded, with different section background images

#### Resources to explore:

- http://swiftiostutorials.com/tutorial-creating-custom-layouts-uicollectionview/
- https://www.raywenderlich.com/147162/iglistkit-tutorial-better-uicollectionviews
- https://www.raywenderlich.com/136161/uicollectionview-tutorial-reusable-views-selection-reordering
- http://strawberrycode.com/blog/how-to-create-a-section-background-in-a-uicollectionview-in-ios-swift/
- http://swiftdeveloperblog.com/display-large-collection-of-images-in-uitableview-with-sdwebimage/
- testing https://github.com/meetup/testing-on-board/blob/master/CLASS.md
- https://www.raywenderlich.com/130197/magical-error-handling-swift
- https://medium.com/@MedvedevTheDev/why-encoding-matters-a-primer-on-bits-bytes-and-history-4ec9dc441355#.6bxpln7wz
- https://www.raywenderlich.com/92667/securing-ios-data-keychain-touch-id-1password
