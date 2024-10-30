//
//  CheckInViewModel.swift
//  employee-check-in
//
//  Created by Jerald Allen Abille on 10/30/24.
//

import Foundation

@Observable
class CheckInViewModel {
    
    // MARK: - Init
    
    init(checkInService: CheckInService = CheckInService(), 
         employeeRepository: EmployeeRepository = EmployeeRepository()) {
        self.checkInService = checkInService
        self.employeeRepository = employeeRepository
        self.df = DateFormatter()
        self.df.dateFormat = "yyyy-MM-dd HH:mm"
    }
    
    // MARK: - Public Properties
    
    var checkInDateTime: Date = .now
    
    // MARK: - Private Properties
    
    private var checkInService: CheckInService
    
    private var employeeRepository: EmployeeRepository
    
    private var df: DateFormatter
    
    // MARK: - Alerts
    
    var showSuccessAlert: Bool = false
    
    let successAlertMessage = "Checked in successfully!"
    
    var showErrorAlert: Bool = false
    
    private(set) var checkInError: CheckInError?
    
    // MARK: - Methods
    
    func setInitialCheckInDateTime() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                if let lastCheckInDate = try employeeRepository.getLastCheckInDateTime() {
                    self.checkInDateTime = lastCheckInDate
                } else {
                    let checkInDateTime = try await checkInService.getCheckInDateTime()
                    if let dateTime = self.df.date(from: checkInDateTime.dateTime) {
                        self.checkInDateTime = dateTime
                    } else {
                        self.checkInError = .somethingWentWrong
                        self.showErrorAlert = true
                    }
                }
            } catch {
                self.checkInError = .somethingWentWrong
                self.showErrorAlert = true
            }
        }
    }
    
    func validateCheckInDateTime() -> Bool {
        guard checkInDateTime <= Date.now else {
            self.checkInError = .dateCannotBeFutureDate
            self.showErrorAlert = true
            return false
        }
        return true
    }
    
    func addCheckInTime() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                try await self.employeeRepository.addCheckInDateTime(checkInDateTime)
                self.showSuccessAlert = true
            } catch {
                self.checkInError = .unableToCheckIn
                self.showErrorAlert = true
            }
        }
    }
    
}
