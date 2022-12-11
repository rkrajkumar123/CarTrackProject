//
//  CTCoreDataManager.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 10/12/22.
//

import Foundation
import CoreData


class CTCoreDataManager {
    static let dataManager = CTCoreDataManager()
    
    private init() {
        
    }
    
    func getLoginCredential() -> LoginCredential?{
        if let widgetEntity = self.getUserCredentialForLoginPage(){
            return widgetEntity
        }
        return nil
    }
    
    func getUserCredentialForLoginPage() -> LoginCredential? {
        let privateMoc = CTCoreDataHelper.dataHelper.persistentContainer.viewContext
        let fetchContext = LoginCredential.fetchRequest(fromContext: privateMoc)
        return fetchContext
    }
    
    func saveUserCredential(model:LoginCredentialModel){
        let privateMoc = CTCoreDataHelper.dataHelper.persistentContainer.viewContext
        let fetchContext =  LoginCredential(context: privateMoc)
        fetchContext.email = model.email
        fetchContext.password = model.password
        fetchContext.isLogin = model.isLogin
        CTCoreDataHelper.dataHelper.saveOnContext()
    }
    func updateUserLoginStatus(isLogin:Bool){
        let privateMoc = CTCoreDataHelper.dataHelper.persistentContainer.viewContext
        let fetchContext = LoginCredential.fetchRequest(fromContext: privateMoc)
        fetchContext?.isLogin = isLogin
        CTCoreDataHelper.dataHelper.saveOnContext()
    }
}
