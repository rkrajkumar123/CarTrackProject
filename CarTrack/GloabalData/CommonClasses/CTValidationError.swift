//
//  CTValidationError.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 09/12/22.
//

import Foundation

//MARK:  Used For validation handling in textfield
struct CTValidationError {
    var errorString: String? = nil
    
    init(message: String) {
        errorString = message
    }
    
    // MARK: Validation Error Messages
    struct ErrorMessages {
        static let msgEmptyEmail = "Please enter email id"
        static let msgInvalidEmail = "Please enter a valid email id"
        static let msgInvalidPassword = "Password should be minimum 6 characters"
        static let msgEmptyPassword = "Please enter password"
        static let msgEmptyCountry = "Please select country"
    }
}
