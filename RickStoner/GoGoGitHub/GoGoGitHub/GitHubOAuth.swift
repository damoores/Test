//
//  GitHubOAuth.swift
//  GoGoGitHub
//
//  Created by Rick  on 6/27/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import Foundation

let kAccessTokenKey = "kAccessTokenKey"
let kOAuthBaseURLString = "http://github.com/login/oauth/"
let kAccessTokenRegexPattern = "access_token=()[^&]+)"

typealias GitHubOAuthCompletion = (success: Bool) ->()

enum GitHubOAuthError: ErrorType {
    case MissingAcessToken(String)
    case ExtractingTokenFromString(String)
    case ExtractingTemporaryCode(String)
    case ResponseFromGitHub(String)
}

enum SaveOptions: Int {
    case userDefaults
}