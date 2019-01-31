//
//  TartuNetworkManager.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/30/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation

public enum TartuNetworkManager {
    case getTartuEmployees()
}

extension TartuNetworkManager: ServiceEndPoint {
    var baseURL: URL {
        guard let url = URL(string: NetworkEnvironment.tartuDirectoryBaseURL.rawValue) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getTartuEmployees:
            return NetworkEndpoints.employeesList.rawValue
        }
        
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getTartuEmployees():
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [:])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
