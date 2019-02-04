//
//  ServiceEndPoint.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/29/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation

protocol ServiceEndPoint {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
