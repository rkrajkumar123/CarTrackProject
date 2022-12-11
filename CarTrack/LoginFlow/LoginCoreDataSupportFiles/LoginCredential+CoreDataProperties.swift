//
//  LoginCredential+CoreDataProperties.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 10/12/22.
//
//

import Foundation
import CoreData

//MARK: used for core data model on login screen
extension LoginCredential {
    
    class func fetchRequest() -> NSFetchRequest<LoginCredential> {
        return NSFetchRequest<LoginCredential>(entityName: "LoginCredential")
    }
    
    class func fetchRequest(fromContext managedContext: NSManagedObjectContext) ->LoginCredential? {
        do {
            let request : NSFetchRequest<LoginCredential> =  LoginCredential.fetchRequest()
            request.returnsObjectsAsFaults =  true
            let rootArray = try managedContext.fetch(request)
            if let nwEntity = rootArray.first{
                return nwEntity
            }
        }
        catch {
            return nil
        }
        return nil
    }
    
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var isLogin: Bool
    
}
