//
//  RequestManager.swift
//  employee-check-in
//
//  Created by Jerald Allen Abille on 10/30/24.
//

import Foundation

struct RequestManager {
    
    /// Executes given api returning with a result of either response or error.
    func run<Response: Decodable>(api: APIProtocol, resultType: Response.Type) async throws -> Result<Response, Error> {
        let request = api.urlRequest
        print("Executing request: ", request)
        let defaultDate = getDefaultDateTime()
        let defaultDateObject = mockCheckInDateTimeResponseFrom(defaultDate)
        let data = try JSONEncoder().encode(defaultDateObject)
        let response = try JSONDecoder().decode(resultType, from: data)
        return .success(response)
    }
    
    /// Returns the default date and time as 06:30 of the current day.
    private func getDefaultDateTime() -> Date {
        let cal = Calendar.current
        if let defaultTime = cal.date(bySettingHour: 6, minute: 30, second: 0, of: .now) {
            return defaultTime
        }
        return .now
    }
    
    /// Returns CheckInDateTime object.
    private func mockCheckInDateTimeResponseFrom(_ date: Date) -> CheckInDateTime {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        let stringDate = df.string(from: date)
        let checkInDateTime = CheckInDateTime(dateTime: stringDate)
        return checkInDateTime
    }
    
}
