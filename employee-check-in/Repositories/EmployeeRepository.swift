//
//  EmployeeRepository.swift
//  employee-check-in
//
//  Created by Jerald Allen Abille on 10/30/24.
//

import Foundation
import CoreData

class EmployeeRepository {
    
    init(dataManager: DataManager = .shared) {
        self.dataManager = dataManager
        self.df = DateFormatter()
        self.df.dateFormat = "yyyy-MM-dd HH:mm"
    }
    
    private var dataManager: DataManager
    
    private var df: DateFormatter
    
    func addCheckInDateTime(_ date: Date) async throws {
        let context = dataManager.persistentContainer.newBackgroundContext()
        try await context.perform {
            context.automaticallyMergesChangesFromParent = true
            let employee = Employee(context: context)
            let dateString = self.df.string(from: date)
            employee.check_in_date_time = dateString
            
            let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
            let companies = try context.fetch(fetchRequest)
            if let company = companies.first {
                employee.company = company
            }
            
            if context.hasChanges {
                try context.save()
            }
        }
    }
    
    func getAllCheckInDateTime() throws -> [Date] {
        let context = dataManager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
        fetchRequest.sortDescriptors = [ .init(key: "check_in_date_time", ascending: false) ]
        let results = try context.fetch(fetchRequest)
        return results.compactMap({ df.date(from: $0.check_in_date_time ?? "") })
    }
    
    func getLastCheckInDateTime() throws -> Date? {
        try getAllCheckInDateTime().first
    }
    
}
