//
//  CTCoreDataHelper.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 10/12/22.
//

import Foundation
import CoreData

class CTCoreDataHelper {
    
    static let dataHelper = CTCoreDataHelper()
    
    private init() {
        
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.carTrack)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                debugPrint("Error fetch in coreData")
            }
        })
        return container
    }()
    
    func saveOnContext() {
        let context =  persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                _ = error as NSError
                debugPrint("Error fetch in coreData")
            }
        }
    }
}
