//
//  CheckInService.swift
//  employee-check-in
//
//  Created by Jerald Allen Abille on 10/30/24.
//

import Foundation

struct CheckInService {
    
    init(requestManager: RequestManager = RequestManager()) {
        self.requestManager = requestManager
    }
    
    var requestManager: RequestManager
    
    /// Returns the response for GET check in date time.
    func getCheckInDateTime() async throws -> CheckInDateTime {
        let result = try await requestManager.run(api: API.checkInDateTime, resultType: CheckInDateTime.self)
        switch result {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
    
}
