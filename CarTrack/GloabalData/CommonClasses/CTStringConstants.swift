//
//  StringConstants.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 09/12/22.
//

import Foundation

//MARK: used for storing all constants together
class Constants{
    static var requsetTimeOut:TimeInterval = 10
    static var email = "cartrack@gmail.com"
    static var passowrd = "cartrack"
    static var logout = "Logout"
    static var usersList = "Users List"
    static var validationError = "Please enter valid email or password."
    static var dataNotFound = "User Data Not Found!!"
    static var carTrack = "CarTrack"
    static var userLocation = "User Location"
    static var emailId = "Email ID"
    static var password = "Password"
    static var selectCountry = "Select Country"
    static var login = "Login"
    static var countryList = "Country List"
    static var cartrack = "CarTrack"
    static var ok = "Ok"
    class Images{
        static var dataNotFound = "dataNotFound"
        static var user = "user"
        static var loginHeader = "LoginHeader"
    }
    class storyboardNames {
        static let userListingStoryboard = "UserListingStoryboard"
        static let main = "Main"
    }
    
    class BaseUrlType  {
        static var ctBaseURL = "https://jsonplaceholder.typicode.com"
    }

    class PathUrlType  {
        static var users = "/users"
    }
}


