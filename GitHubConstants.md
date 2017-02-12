````swift
// Copy-paste the code below to the Constants.swift file

// If you already have a Meetup account, your API key is here: http://www.meetup.com/meetup_api/key/

enum API {
    static let meetupApiKey = "INSERT-YOUR-API-KEY-HERE"
}


// Your OAuth Consumer keys are here: https://secure.meetup.com/meetup_api/oauth_consumers/ 
// Otherwise, you can create one here: https://secure.meetup.com/meetup_api/oauth_consumers/create

enum OAuth {
    
    static let oAuthKey    = "INSERT-YOUR-OAUTH-KEY-HERE"
    static let oAuthSecret = "INSERT-YOUR-OAUTH-SECRET-HERE"
    static let redirectUri = "INSERT-YOUR-REDIRECT-URI-HERE"
    
    static let authorizationEndpoint = "https://secure.meetup.com/oauth2/authorize"
    static let accessTokenEndpoint = "https://secure.meetup.com/oauth2/access"
    
    static let responseType = "code"
    static let state = "meetup\(Int(Date().timeIntervalSince1970))"
    static let scope = "ageless"
    
    static let meetupAccessToken = "meetupAccessToken"
}


enum PlaceholderImage {
    static let meetupLogoGray = "MeetupLogoGray"
    static let meetupLogoRed  = "MeetupLogo"
}
````
