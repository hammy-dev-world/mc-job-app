//
//  EMSideMenuTableViewDelegateDatasource.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/25/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation
import UIKit

struct EmployeesListTableViewConstants {
    static let kNumberOfSections = 10
    
    static let kHeightForEmployeeRowCell = 200.0
    
    static let kHeightForHeader = 200.0
    static let kHeightForFooter = 10.0
}

class MCEmployeesListTableViewDelegateDatasource: NSObject, UITableViewDataSource, UITableViewDelegate {
    // MARK: Members
    
    // MARK: Callbacks

    // MARK: Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tableView(tableView, cellForEmployeeRowAt: indexPath)
    }
    
    
    // MARK: Delegates
    // MARK: Rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(EmployeesListTableViewConstants.kHeightForEmployeeRowCell)
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
    }
    
    // MARK: Header Views
    func tableView(_ tableView: UITableView, cellForEmployeeGroupRowAsSectionAt section: Int) -> UITableViewCell {
        let cell: MCEmployeeGroupTableViewCell = (tableView.dequeueReusableCell(withIdentifier: ApplicationInterfaceFilenames.kEmployeeGroupTableViewCell) as? MCEmployeeGroupTableViewCell)!

        return cell
    }

    // MARK: Cell Views
    func tableView(_ tableView: UITableView, cellForEmployeeRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MCEmployeeRowTableViewCell = (tableView.dequeueReusableCell(withIdentifier: ApplicationInterfaceFilenames.kEmployeeRowTableViewCell, for: indexPath) as? MCEmployeeRowTableViewCell)!
        
        return cell
    }
}
