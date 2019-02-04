//
//  ApplicationViewControllers.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 2/4/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation
import UIKit

extension MCEmployeesListViewController: UISearchResultsUpdating {
    // MARK: Delegates
    // MARK: UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterEmployeesOnProject(searchString: String) -> [MCEmployeeRootObject] {
        var filtered: [MCEmployeeRootObject]! = []
        
        for employee in self.newEmployees {
            let projects = employee.projects
            
            let filteredStrings = projects.filter({(project: String) -> Bool in
                let stringMatch = project.rawString.range(of: searchString.rawString)
                return stringMatch != nil ? true : false
            })
            
            if filteredStrings.count > 0 {
                filtered.append(employee)
            }
        }
        
        return filtered
    }
}
