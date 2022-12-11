//
//  LoginDataManager.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 10/12/22.
//

import Foundation

//MARK: class used for managing the login flow
class LoginDataManager{
    static let sharedManager = LoginDataManager()
    private init() {
        
    }
    
    //MARK: saved user credential at the first
    func saveLoginCredential(){
        if let _ = LoginDataManager.sharedManager.getLoginCredential(){
            return
        }
        var obj = LoginCredentialModel()
        obj.isLogin = false
        obj.password = Constants.passowrd
        obj.email = Constants.email
        CTCoreDataManager.dataManager.saveUserCredential(model: obj)
    }
    
    //MARK: getting credential from Core data and validating with currently filling form
    func getLoginCredential()->LoginCredentialModel?{
        if let obj = CTCoreDataManager.dataManager.getLoginCredential(){
            var loginCredentialModel = LoginCredentialModel()
            loginCredentialModel.password = obj.password ?? ""
            loginCredentialModel.email = obj.email ?? ""
            loginCredentialModel.isLogin = obj.isLogin
            return loginCredentialModel
        }
        return nil
    }
    
    //MARK: updating loging status after login and logout
    func updateLoginStatus(isUserLogin:Bool){
        CTCoreDataManager.dataManager.updateUserLoginStatus(isLogin: isUserLogin)
    }
    
    
}
