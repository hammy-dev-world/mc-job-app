//
//  ApplicationConstants.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/25/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation

struct ApplicationStringConstants {
    // MARK: Placeholders
    static let kEmployeesSearchBarPlaceholder = "Search Employees"

}

struct ApplicationNavigationTitles {
    static let kEmployeesListNavigationTitle = "Employees"
    static let kEmployeeProfileNavigationTitle = "Profile"
    static let kEmployeeContactViewNavigationTitle = "Contact View"
}

struct ApplicationNumberConstants {
    // MARK: Navigation Bar
    static let kLeftBarButtonWidth = 30.0
    static let kLeftBarButtonHeight = 30.0
}


struct ApplicationKeyStrings {
    // MARK: Employees
    static let kLocationKeyString = "location"
}

struct ApplicationResourceFilenames {
    // MARK: Navigation Bar
    static let kNavigationBackButton = "back"
    static let kNavigationCallButton = "call"

}

struct ApplicationInterfaceFilenames {
    static let kEmployeesListViewController = "MCEmployeesListView"
    static let kEmployeeRowTableViewCell = "MCEmployeeRowTableViewCell"
    static let kEmployeeGroupTableViewCell = "MCEmployeeGroupTableViewCell"

    static let kEmployeeProfileViewController = "MCEmployeeProfileView"
    static let kEmployeeProfileHeaderTableViewCell = "MCEmployeeProfileHeaderTableViewCell"
    static let kEmployeeProfileSectionTableViewCell = "MCEmployeeProfileSectionTableViewCell"
    static let kEmployeeCallSectionTableViewCell = "MCEmployeeCallSectionTableViewCell"
}

struct ApplicationAlertMessages {
    // MARK: Titles
    static let kAlertTitle = "Alert"

    // MARK: Actions
    static let kCancelAction = "Cancel"

    // MARK: Messages
    static let kNetworkErrorFetchingEmployees = "Something went wrong while fetching employees from the server."
    static let kDeviceContactsErrorFetchingEmployees = "Something went wrong while fetching contacts from the device."
}

struct EmployeeLocation {
    static let kTallinnLocationName = "Tallinn"
    static let kTartuLocationName = "Tartu"
}

struct EmployeesCachingFilename {
    static let kTallinnCachingFilename = "tallinn_filename"
    static let kTartuCachingFilename = "tartu_filename"
}

