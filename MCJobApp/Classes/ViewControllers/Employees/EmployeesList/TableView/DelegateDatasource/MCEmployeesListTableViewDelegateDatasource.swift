//
//  MCEmployeesListTableViewDelegateDatasource.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/25/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation
import UIKit
import ContactsUI

struct EmployeesListTableViewConstants {
    static let kNumberOfSections = 10
    
    static let kHeightForEmployeeRowCell = 102.0
    
    static let kHeightForHeader = 40.0
    static let kHeightForFooter = 2.0
}

class MCEmployeesListTableViewDelegateDatasource: NSObject, UITableViewDataSource, UITableViewDelegate {
    // MARK: Members
    public var employeesList: [(key: String, value: [MCEmployeeRootObject])] = []
    public var contactList: [CNContact] = []

    // MARK: Callbacks
    public var didTapEmployeeRowCallback : ((_ employee: MCEmployeeRootObject, _ phoneContact: [CNContact]) -> Void)?
    public var didTapCallButtonCallback : ((_ phoneContact: CNContact) -> Void)?

    // MARK: Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.employeesList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let employeesForSection = self.employeesList[section]
        
        return employeesForSection.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tableView(tableView, cellForEmployeeRowAt: indexPath)
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
        return CGFloat(EmployeesListTableViewConstants.kHeightForEmployeeRowCell)
    }
    
    // MARK: Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(EmployeesListTableViewConstants.kHeightForHeader)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.tableView(tableView, cellForEmployeeGroupRowAsSectionAt: section)
    }
    
    // MARK: Footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(EmployeesListTableViewConstants.kHeightForFooter)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(EmployeesListTableViewConstants.kHeightForFooter)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
        
    // MARK: Selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let employeesForSection = self.employeesList[indexPath.section]
        
        let employee: MCEmployeeRootObject = employeesForSection.value[indexPath.row]

        let filteredContact: [CNContact] = MCUtilitiesClass.sharedInstance.lookForEmployeeInContactList(employee: employee, contacts: self.contactList)

        if self.didTapEmployeeRowCallback != nil {
            self.didTapEmployeeRowCallback!(employee, filteredContact)
        }
    }
    
    // MARK: Header Views
    func tableView(_ tableView: UITableView, cellForEmployeeGroupRowAsSectionAt section: Int) -> UITableViewCell {
        let cell: MCEmployeeGroupTableViewCell = (tableView.dequeueReusableCell(withIdentifier: ApplicationInterfaceFilenames.kEmployeeGroupTableViewCell) as? MCEmployeeGroupTableViewCell)!

        let employeesForSection = self.employeesList[section]

        cell.setPositionGroup(positionGroupName: employeesForSection.key, section: section)

        return cell
    }

    // MARK: Cell Views
    func tableView(_ tableView: UITableView, cellForEmployeeRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MCEmployeeRowTableViewCell = (tableView.dequeueReusableCell(withIdentifier: ApplicationInterfaceFilenames.kEmployeeRowTableViewCell, for: indexPath) as? MCEmployeeRowTableViewCell)!
        
        let employeesForSection = self.employeesList[indexPath.section]

        let employee: MCEmployeeRootObject = employeesForSection.value[indexPath.row]
        
        let filteredContacts: [CNContact] = MCUtilitiesClass.sharedInstance.lookForEmployeeInContactList(employee: employee, contacts: self.contactList)
        
        var phoneContactRootObject: CNContact = CNContact()
        
        if filteredContacts.count > 0 {
            phoneContactRootObject = filteredContacts[0]
            
            cell.callButton.isHidden = false
        } else {
            cell.callButton.isHidden = true
        }
        
        cell.didTapCallButtonCallback = {phoneContact in
            if self.didTapCallButtonCallback != nil {
                self.didTapCallButtonCallback!(phoneContact)
            }
        }
        
        cell.setEmployee(employeeRootObject: employee, phoneContactRootObject: phoneContactRootObject, row: indexPath.row)
        
        return cell
    }
}
