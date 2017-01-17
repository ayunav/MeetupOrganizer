# Meetup Organizer
📲 An iOS app for meetup goers, hosts, and organizers that extends native Meetup app's functionality and lets you upload multiple photos to meetup events. 

**Acknowledgements**: 

- [CocoaPods NYC Meetup](https://www.meetup.com/CocoaPods-NYC/) - peer lab
- [Alamofire](https://github.com/Alamofire/Alamofire) - HTTP networking library 
- [BSImagePicker](https://github.com/mikaoj/BSImagePicker) - replacement for UIImagePickerController for multiple image selection 
- [NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView) - collection of awesome loading animations
- [OAuthSwift](https://github.com/OAuthSwift/OAuthSwift/) - Swift based OAuth library for iOS and OSX

**Resources**: 

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
  

**TO-DO:** 

- beautify collection view photo gallery  

- add and display placeholder image in the gallery collection view
- on navigation to AddPhotosVC, display photos that are already on the server (fetch photos, display in the collection view)
- when uploading new photos, add new photos to the col view 

- improve response time on fetching upcoming and past events: cache response, add pull to refresh
- add log out/switch account button

- refactor auth code, separate into a different manager class
- handle errors, create user facing alerts 
- add "Logging in..." progress indicator and "Successful login" UI/UX
- add empty states: No upcoming events, no past events 

- nit: request access to photos on add photos button tapped, not on vc navigation 
- nit: change back nav button to red meetup color arrow, no string

- upload activity indicator per cell
    - 1. the col view will display selected photos
    - 2. change cells' alpha to opaque
    - 3. add spinning activity indicators indicating upload progress per photo/per cell
    - 4. if there's a problem with upload, display a user facing error message
    - 5. when upload is complete & successful (json response came back), stop & hide activity indicators, change cells' aipha to clear

- ? add waitlist events
- ? deep link to photos at the event, or to the event, or to the meetup group. Play with it. 
- ? add caption to uploaded photos: Uploaded by <member name> via Meetup Organizer iOS app by Ayuna Vogel (include link?)

- single collection view cell selection to bring up a detail view
- 2 sections for the images that are already on the server, and for the newly uploaded, with different section background images 



**Unused resources:**

- https://www.raywenderlich.com/147162/iglistkit-tutorial-better-uicollectionviews
- https://www.raywenderlich.com/136161/uicollectionview-tutorial-reusable-views-selection-reordering
- http://strawberrycode.com/blog/how-to-create-a-section-background-in-a-uicollectionview-in-ios-swift/
- http://swiftdeveloperblog.com/display-large-collection-of-images-in-uitableview-with-sdwebimage/
- testing https://github.com/meetup/testing-on-board/blob/master/CLASS.md
- https://www.raywenderlich.com/130197/magical-error-handling-swift
- https://medium.com/@MedvedevTheDev/why-encoding-matters-a-primer-on-bits-bytes-and-history-4ec9dc441355#.6bxpln7wz
- https://www.raywenderlich.com/92667/securing-ios-data-keychain-touch-id-1password
