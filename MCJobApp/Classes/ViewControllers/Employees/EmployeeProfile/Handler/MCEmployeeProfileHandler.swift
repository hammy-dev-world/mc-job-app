//
//  MCEmployeeProfileHandler.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 2/2/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation

class MCEmployeeProfileHandler: NSObject {
    // MARK: Instance Variables
    var viewController: MCEmployeeProfileViewController!
    var view: MCEmployeeProfileView!
    
    // MARK: Init
    required init(viewController: MCEmployeeProfileViewController!) {
        self.viewController = viewController
        self.view = self.viewController.employeesProfileView
    }
    
    //MARK: Callbacks
    
    //MARK: Public Methods
    
    //MARK: Private Methods
    //MARK: Operation

    // MARK: Common

    // MARK: Events
}

