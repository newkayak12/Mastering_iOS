//
//  PhotoMigrationV1ToV2.swift
//  CoreData
//
//  Created by Sang Hyeon kim on 2023/01/03.
//  Copyright © 2023 Keun young Kim. All rights reserved.
//

import Foundation
import CoreData
@objc(PhotoMigrationV1ToV2)
class PhotoMigrationV1ToV2: NSEntityMigrationPolicy {
    override func createDestinationInstances(forSource sInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        try super.createDestinationInstances(forSource: sInstance, in: mapping, manager: manager)
        if let photo = sInstance.value(forKey: "photo") as? Data {
            let context = manager.destinationContext
            let newPhoto = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: context)
            newPhoto.setValue(photo, forKey: "photo")
            print("new photo")
            
            let destResults = manager.destinationInstances(forEntityMappingName: mapping.name, sourceInstances: [sInstance])
            if let employee = destResults.last{
                employee.setValue(newPhoto, forKey: "profile")
                print("employee -> photo")
            }
        }
        
        
    }
}
