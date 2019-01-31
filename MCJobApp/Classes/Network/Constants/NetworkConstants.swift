//
//  NetworkConstants.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/30/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation

enum NetworkEnvironment: String {
    case tartuDirectoryBaseURL = "https://tartu-jobapp.aw.ee/"
    case tallinnDirectoryBaseURL = "https://tallinn-jobapp.aw.ee/"
}

enum NetworkEndpoints: String {
    case employeesList = "employee_list"
}

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}
