//
//  NetworkResponseHandler.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/31/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation

class NetworkResponseHandler: NSObject {
    // MARK: Class Variables
    static public let sharedInstance = NetworkResponseHandler()
    
    // MARK: Instance methods
    public func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
