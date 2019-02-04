//
//  MCUtilitiesClass.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 2/3/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation
import UIKit
import ContactsUI

class MCUtilitiesClass: NSObject {
    // MARK: Class Variables
    static public let sharedInstance = MCUtilitiesClass()

    // MARK: Public methods
    // MARK: Employees
    public func lookForEmployeeInContactList(employee: MCEmployeeRootObject, contacts: [CNContact]) -> [CNContact] {
        let employeeName = employee.firstName + " " + employee.lastName
    
        return contacts.filter( { return $0.givenName.rawString + $0.middleName.rawString + $0.familyName.rawString == employeeName.rawString} )
    }
}
