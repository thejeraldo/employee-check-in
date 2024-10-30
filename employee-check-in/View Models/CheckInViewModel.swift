//
//  CheckInViewModel.swift
//  employee-check-in
//
//  Created by Jerald Allen Abille on 10/30/24.
//

import Foundation
import Combine

@Observable
class CheckInViewModel {
    
    init(checkInService: CheckInService = CheckInService(), 
         employeeRepository: EmployeeRepository = EmployeeRepository()) {
        self.checkInService = checkInService
        self.employeeRepository = employeeRepository
        self.df = DateFormatter()
        self.df.dateFormat = "yyyy-MM-dd HH:mm"
    }
    
    var checkInDateTime: Date = .now
    
    private var checkInService: CheckInService
    
    private var employeeRepository: EmployeeRepository
    
    private var df: DateFormatter
    
    func setInitialCheckInDateTime() {
        Task {
            do {
                if let lastCheckInDate = try employeeRepository.getLastCheckInDateTime() {
                    self.checkInDateTime = lastCheckInDate
                } else {
                    let checkInDateTime = try await checkInService.getCheckInDateTime()
                    if let dateTime = self.df.date(from: checkInDateTime.dateTime) {
                        self.checkInDateTime = dateTime
                    } else {
                        // Throw an error for failing to get date.
                    }
                }
            } catch {
                // Do something with the error here.
            }
        }
    }
    
    func addCheckInTime() {
        do {
            try employeeRepository.addCheckInDateTime(checkInDateTime)
        } catch {
            print(error)
        }
    }
    
}
