//
//  EmployeeEntity+CoreDataProperties.swift
//  CoreData
//
//  Created by Sang Hyeon kim on 2022/12/31.
//  Copyright © 2022 Keun young Kim. All rights reserved.
//
//

import Foundation
import CoreData


extension EmployeeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeeEntity> {
        return NSFetchRequest<EmployeeEntity>(entityName: "Employee")
    }

    @NSManaged public var salary: NSDecimalNumber?
    @NSManaged public var contact: Contact?
    @NSManaged public var photo: NSData?
    @NSManaged public var department: DepartmentEntity?

}
