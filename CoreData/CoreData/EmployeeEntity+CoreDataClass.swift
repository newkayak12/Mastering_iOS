//
//  EmployeeEntity+CoreDataClass.swift
//  CoreData
//
//  Created by Sang Hyeon kim on 2022/12/31.
//  Copyright © 2022 Keun young Kim. All rights reserved.
//
//

import Foundation
import CoreData

@objc(EmployeeEntity)
public class EmployeeEntity: PersonEntity {
//    @objc func validateAge(_ value: AutoreleasingUnsafeMutablePointer<AnyObject?>) throws {
//        guard let ageValue = value.pointee as? Int else { return }
//        print(ageValue < 20 || ageValue > 50 )
//        if ageValue < 20 || ageValue > 50 {
//        print(ageValue)
//            let msg = "Age value must be between 20 and 50."
//            let code = ageValue < 20 ? NSValidationNumberTooSmallError : NSValidationNumberTooLargeError
//            let error = NSError(domain: NSCocoaErrorDomain, code: code, userInfo: [NSLocalizedDescriptionKey: msg])
//            throw error
//        }
//    }
//    
//    func validateAgeWithDepartment() throws {
//        guard let deptName = department?.name, deptName == "Development" else {
//            return
//        }
//        
//        guard age > 30 else {
//            return
//        }
//        
//        let msg = "The Development department cannot have employees under 30 years of age."
//        let code = NSValidationInvalidAgeAndDepartment
//        let error = NSError(domain: NSCocoaErrorDomain, code: code, userInfo: [NSLocalizedDescriptionKey:msg])
//        throw error
//    }
//    
//    public override func validateForInsert() throws {
//        try super.validateForInsert()
//        try validateAgeWithDepartment()
//    }
//    
//    public override func validateForUpdate() throws {
//        try super.validateForUpdate()
//        try validateAgeWithDepartment()
//    }
}
public let NSValidationInvalidAgeAndDepartment = Int.max - 100
