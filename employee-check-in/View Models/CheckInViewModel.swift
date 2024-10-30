//
//  CheckInViewModel.swift
//  employee-check-in
//
//  Created by Jerald Allen Abille on 10/30/24.
//

import Foundation

@Observable
class CheckInViewModel {
    
    init(checkInService: CheckInService = CheckInService()) {
        self.checkInService = checkInService
        self.df = DateFormatter()
        self.df.dateFormat = "yyyy-MM-dd HH:mm"
    }
    
    var checkInDateTime: Date = .now
    
    private var checkInService: CheckInService
    
    private var df: DateFormatter
    
    func getCheckInDateTime() {
        Task {
            do {
                let checkInDateTime = try await checkInService.getCheckInDateTime()
                if let dateTime = self.df.date(from: checkInDateTime.dateTime) {
                    self.checkInDateTime = dateTime
                } else {
                    // Throw an error for failing to get date.
                }
            } catch {
                // Do something with the error here.
            }
        }
    }
    
}
