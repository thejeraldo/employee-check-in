//
//  Employee+CoreDataProperties.swift
//  employee-check-in
//
//  Created by Jerald Allen Abille on 10/31/24.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var check_in_date_time: String?
    @NSManaged public var company: Company?

}

extension Employee : Identifiable {

}
