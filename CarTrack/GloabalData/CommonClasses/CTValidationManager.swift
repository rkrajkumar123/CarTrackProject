//
//  CTValidationManager.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 09/12/22.
//

import Foundation

//MARK: Used for validating handling
struct CTValidationManager {
    static private let stringSelfMatch = "SELF MATCHES %@"
    static private let regexEmail = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    static private let regexPassword = ".{6,}"
    
    static func validateEmailForLogin(_ email: String?) -> CTValidationError?{
        
        var validationError: CTValidationError? = nil
        if let email = email{
            if email == "" {
                validationError = CTValidationError(message:  CTValidationError.ErrorMessages.msgEmptyEmail)
                
            } else {
                let emailTest = NSPredicate(format: CTValidationManager.stringSelfMatch, CTValidationManager.regexEmail)
                let matchEmailId = emailTest.evaluate(with: email)
                
                if !matchEmailId {
                    validationError = CTValidationError(message:  CTValidationError.ErrorMessages.msgInvalidEmail)
                }
            }
        }else{
            validationError = CTValidationError(message:  CTValidationError.ErrorMessages.msgEmptyEmail)
        }
        return validationError
    }
    
    static func validatePassword(_ passwd: String?) -> CTValidationError? {
        if let passwd =  passwd{
            let nameTest = NSPredicate(format: stringSelfMatch, regexPassword)
            let matchNameType = nameTest.evaluate(with: passwd)
            if matchNameType == false {
                return CTValidationError(message: CTValidationError.ErrorMessages.msgInvalidPassword)
            }
            return nil
        }
        return CTValidationError(message: CTValidationError.ErrorMessages.msgEmptyPassword)
    }
    
    static func validateDropDown(_ selectedValue: String?) -> CTValidationError? {
        if let selectedValue =  selectedValue,selectedValue.isEmpty{
            return CTValidationError(message: CTValidationError.ErrorMessages.msgEmptyCountry)
        }
        return nil
    }
}
