//
//  MCEmployeeProfileTableViewDelegateDatasource.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 2/2/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation
import UIKit
import ContactsUI

struct EmployeeProfileTableViewConstants {
    static let kNumberOfSections = 1
    
    static let kHeightForEmployeeHeaderCell = 200.0
    static let kHeightForEmployeeSectionCell = 50.0
    static let kHeightForCallSectionCell = 80.0

    static let kHeightForHeader = 0.0
    static let kHeightForFooter = 0.0
    
    static let kNumberOfInformationSections = 6
}

class MCEmployeeProfileTableViewDelegateDatasource: NSObject, UITableViewDataSource, UITableViewDelegate {
    // MARK: Members
    public var employee: MCEmployeeRootObject!
    public var contacts: [CNContact] = []

    // MARK: Callbacks
    public var didTapCallButtonCallback : ((_ phoneContact: CNContact) -> Void)?

    // MARK: Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.contacts.count > 0 {
            return Int(EmployeeProfileTableViewConstants.kNumberOfInformationSections)
        } else {
            return Int(EmployeeProfileTableViewConstants.kNumberOfInformationSections) - 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return self.tableView(tableView, cellForEmployeeProfileHeaderAt: indexPath)
        case 1...4:
            return self.tableView(tableView, cellForEmployeeProfileSectionAt: indexPath)
        case 5:
            return self.tableView(tableView, cellForEmployeeCallSectionAt: indexPath)
        default:
            return self.tableView(tableView, cellForEmployeeProfileSectionAt: indexPath)
        }
    }
    
    // MARK: Delegates

    // MARK: Drawing
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    // MARK: Rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return CGFloat(EmployeeProfileTableViewConstants.kHeightForEmployeeHeaderCell)
        case 1...4:
            return CGFloat(EmployeeProfileTableViewConstants.kHeightForEmployeeSectionCell)
        case 5:
            return CGFloat(EmployeeProfileTableViewConstants.kHeightForCallSectionCell)
        default:
            return CGFloat(EmployeeProfileTableViewConstants.kHeightForEmployeeSectionCell)
        }
    }
    
    // MARK: Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(EmployeeProfileTableViewConstants.kHeightForHeader)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(EmployeeProfileTableViewConstants.kHeightForHeader)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    // MARK: Footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(EmployeeProfileTableViewConstants.kHeightForFooter)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(EmployeeProfileTableViewConstants.kHeightForFooter)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
        
    // MARK: Selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    // MARK: Cell Views
    func tableView(_ tableView: UITableView, cellForEmployeeProfileHeaderAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MCEmployeeProfileHeaderTableViewCell = (tableView.dequeueReusableCell(withIdentifier: ApplicationInterfaceFilenames.kEmployeeProfileHeaderTableViewCell, for: indexPath) as? MCEmployeeProfileHeaderTableViewCell)!
    
        cell.setEmployee(employeeRootObject: self.employee, row: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForEmployeeProfileSectionAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MCEmployeeProfileSectionTableViewCell = (tableView.dequeueReusableCell(withIdentifier: ApplicationInterfaceFilenames.kEmployeeProfileSectionTableViewCell, for: indexPath) as? MCEmployeeProfileSectionTableViewCell)!
        
        cell.setEmployee(employeeRootObject: self.employee, row: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForEmployeeCallSectionAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MCEmployeeCallSectionTableViewCell = (tableView.dequeueReusableCell(withIdentifier: ApplicationInterfaceFilenames.kEmployeeCallSectionTableViewCell, for: indexPath) as? MCEmployeeCallSectionTableViewCell)!
        
        cell.setEmployee(employeeRootObject: self.employee, phoneContactRootObject: self.contacts[0], row: indexPath.row)
        
        cell.didTapCallButtonCallback = {phoneContact in
            if self.didTapCallButtonCallback != nil {
                self.didTapCallButtonCallback!(phoneContact)
            }
        }

        return cell
    }
}
