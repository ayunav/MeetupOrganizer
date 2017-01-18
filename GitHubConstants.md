````swift
// Copy-paste the code below to the Constants.swift file

// If you already have a Meetup account, your API key is here: http://www.meetup.com/meetup_api/key/

let MeetupApiKey = "INSERT-YOUR-API-KEY-HERE" 

// Your OAuth Consumer keys are here: https://secure.meetup.com/meetup_api/oauth_consumers/ 
// Otherwise, you can create one here: https://secure.meetup.com/meetup_api/oauth_consumers/create

let OAuthKey     = "INSERT-YOUR-OAUTH-KEY-HERE"
let OAuthSecret  = "INSERT-YOUR-OAUTH-SECRET-HERE"
let RedirectUri  = "INSERT-YOUR-REDIRECT-URI-HERE"

let AuthorizationEndpoint = "https://secure.meetup.com/oauth2/authorize"
let AccessTokenEndpoint = "https://secure.meetup.com/oauth2/access"

let ResponseType = "code"
let State = "meetup\(Int(Date().timeIntervalSince1970))"
let Scope = "ageless" 
````
