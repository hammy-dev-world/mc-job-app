//
//  MCEmployeesListViewController.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/25/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import UIKit

class MCEmployeesListViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var employeesListView: MCEmployeesListView!

    // MARK: Instance Variables
    var employeesTableViewDelegateDatasource: MCEmployeesListTableViewDelegateDatasource?

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureObjects()
        self.configureTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.configureNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    // MARK: Private Methods
    // MARK: Navigation Bar
    private func configureNavigationBar() -> Void {
        self.navigationController?.isNavigationBarHidden = false
        
        self.title = ApplicationNavigationTitles.kEmployeesListNavigationTitle
    }

    // MARK: Objects
    private func configureObjects() {
        self.employeesTableViewDelegateDatasource = MCEmployeesListTableViewDelegateDatasource()
    }

    // MARK: Table View
    private func configureTableView() {
        self.employeesListView.employeesListTableView.delegate = self.employeesTableViewDelegateDatasource
        self.employeesListView.employeesListTableView.dataSource = self.employeesTableViewDelegateDatasource
        
        self.employeesListView.employeesListTableView.register(UINib(nibName: ApplicationInterfaceFilenames.kEmployeeGroupTableViewCell, bundle: nil), forCellReuseIdentifier: ApplicationInterfaceFilenames.kEmployeeGroupTableViewCell)
        self.employeesListView.employeesListTableView.register(UINib(nibName: ApplicationInterfaceFilenames.kEmployeeRowTableViewCell, bundle: nil), forCellReuseIdentifier: ApplicationInterfaceFilenames.kEmployeeRowTableViewCell)
    }


}

