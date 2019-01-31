//
//  TallinnNetworkManager.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/30/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation

public enum TallinnNetworkManager {
    case getTallinnEmployees()
}

extension TallinnNetworkManager: ServiceEndPoint {
    var baseURL: URL {
        guard let url = URL(string: NetworkEnvironment.tallinnDirectoryBaseURL.rawValue) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getTallinnEmployees:
            return NetworkEndpoints.employeesList.rawValue
        }
        
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getTallinnEmployees():
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [:])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
