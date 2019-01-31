//
//  MCEmployeeContactObject.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/30/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation

struct MCEmployeeContactObject {
    let phoneNumber: String
    let emailAddress: String
}

extension MCEmployeeContactObject: Decodable {
    
    private enum EmployeeContactDetailsCodingKeys: String, CodingKey {
        case phoneNumber = "phone"
        case emailAddress = "email"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: EmployeeContactDetailsCodingKeys.self)
        
        self.phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber) ?? ""
        self.emailAddress = try container.decodeIfPresent(String.self, forKey: .emailAddress) ?? ""
    }
}
