//
//  MCEmployeeRootObject.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/30/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation

struct MCEmployeeRootObject {
    let firstName: String
    let lastName: String
    let position: String
    let location: String
    let contactDetails: MCEmployeeContactObject
    let projects: [String]
}

extension MCEmployeeRootObject: Decodable {
    public enum EmployeeCodingKeys: String, CodingKey {
        case firstName = "fname"
        case lastName = "lname"
        case position = "position"
        case location = "location"
        case contactDetails = "contact_details"
        case projects = "projects"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: EmployeeCodingKeys.self)

        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName) ?? ""
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName) ?? ""
        self.position = try container.decodeIfPresent(String.self, forKey: .position) ?? ""
        self.location = try container.decodeIfPresent(String.self, forKey: .location) ?? ""
        self.contactDetails = try container.decodeIfPresent(MCEmployeeContactObject.self, forKey: .contactDetails) ?? MCEmployeeContactObject(phoneNumber: "", emailAddress: "")
        self.projects = try container.decodeIfPresent([String].self, forKey: .projects) ?? []
    }
}
