//
//  ApplicationCachables.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 2/4/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation

struct TallinnEmployeesListCachable: Cachable, Codable {
    let fileName: String = EmployeesCachingFilename.kTallinnCachingFilename
    let value: Data
}

struct TartuEmployeesListCachable: Cachable, Codable {
    let fileName: String = EmployeesCachingFilename.kTartuCachingFilename
    let value: Data
}
