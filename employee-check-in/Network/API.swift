//
//  API.swift
//  employee-check-in
//
//  Created by Jerald Allen Abille on 10/30/24.
//

import Foundation

protocol APIProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var method: String { get }
    var urlRequest: URLRequest { get }
}

enum API: APIProtocol {
    
    case checkInDateTime
    
    var baseURL: URL { return URL(string: "https://mock.com/api")! }
    
    var path: String {
        switch self {
        case .checkInDateTime:
            return "check_in_date_time"
        }
    }
    
    var method: String {
        switch self {
        case .checkInDateTime:
            return "GET"
        }
    }
    
    var urlRequest: URLRequest {
        let url = self.baseURL.appending(path: self.path)
        var request = URLRequest(url: url)
        request.httpMethod = self.method
        return request
    }
    
}
