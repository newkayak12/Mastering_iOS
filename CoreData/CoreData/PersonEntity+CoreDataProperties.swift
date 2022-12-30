//
//  PersonEntity+CoreDataProperties.swift
//  CoreData
//
//  Created by Sang Hyeon kim on 2022/12/30.
//  Copyright © 2022 Keun young Kim. All rights reserved.
//
//

import Foundation
import CoreData


extension PersonEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonEntity> {
        return NSFetchRequest<PersonEntity>(entityName: "Person")
    }

    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var name: String?

}
