//
//  MCEmployeesListRootObject.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/30/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation

struct MCEmployeesListRootObject {
    let employees: [MCEmployeeRootObject]
}

extension MCEmployeesListRootObject: Decodable {
    
    private enum EmployeesRootApiResponseCodingKeys: String, CodingKey {
        case employees = "employees"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: EmployeesRootApiResponseCodingKeys.self)
        
        employees = try container.decode([MCEmployeeRootObject].self, forKey: .employees)
    }
}
