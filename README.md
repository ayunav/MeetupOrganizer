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
- [How to hide your API keys](https://gist.github.com/derzorngottes/3b57edc1f996dddcab25) add my own link on Monday make cookbooks public
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

- on navigation to addPhotosVC display photos that are already on the server (fetch photos, display in the col view)
- when uploading new photos, add new photos to the col view 
- beautify collection view photo gallery  

- improve response time on fetching upcoming and past events: cache response, add pull to refresh
- oAuth glitch fix 
- add log out/switch account button
- handle errors, create user facing alerts (MeetupAPI completion blocks results)
- nit: request access to photos on add photos button tapped, not on vc navigation 
- nit: change back nav button to red meetup color arrow, no string
- ? add waitlist events, too. (to upcoming events)
- ? deep link to photos at the event, or to the event, or to the meetup group. Play with it. 


### avmeetup: 

- get rid of the space between segm control and the table view 
- add search bar to nav bar 
- networking requests for search - text/ location / combination  
- favorites button animation 
- sort favorites by date on display
- error handling 
- next steps: 
    - add pagination 
    - add location request 

**Unused resources:**

- https://grokswift.com/swift-tableview-search-bar/
- https://www.raywenderlich.com/129059/self-sizing-table-view-cells
- https://www.raywenderlich.com/136161/uicollectionview-tutorial-reusable-views-selection-reordering
- https://www.raywenderlich.com/147162/iglistkit-tutorial-better-uicollectionviews
- testing https://github.com/meetup/testing-on-board/blob/master/CLASS.md
- https://www.raywenderlich.com/130197/magical-error-handling-swift
- https://medium.com/@MedvedevTheDev/why-encoding-matters-a-primer-on-bits-bytes-and-history-4ec9dc441355#.6bxpln7wz
- https://medium.com/@joannathhuang/variadic-and-in-out-parameters-9b757c44228e#.vsv6ax6xo
- [Adding a segmented control programmatically](http://www.richardhsu.me/posts/2015/01/26/segmented-control.html)
- https://www.raywenderlich.com/92667/securing-ios-data-keychain-touch-id-1password
