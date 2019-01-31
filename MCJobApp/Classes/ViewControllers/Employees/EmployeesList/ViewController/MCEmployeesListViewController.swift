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

    var handler: MCEmployeesListHandler!

    var allEmployees: [MCEmployeeRootObject]! = []

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureHandler()
        self.configureObjects()
        self.configureTableView()
        self.configureCallbacks()
        
        self.loadEmployees()
        
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

    // MARK: Handler
    private func configureHandler() -> Void{
        self.handler = MCEmployeesListHandler(viewController: self)
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
    
    // MARK: Callbacks
    private func configureCallbacks() {
        weak var weakSelf = self
        
        self.handler.didReceiveSuccessFetchingTallinnEmployeesCallback = {response in
            weakSelf?.handleFetchTallinnEmployeesResponseEvent(employeesList: (response)!)
        }
        
        self.handler.didReceiveSuccessFetchingTartuEmployeesCallback = {response in
            weakSelf?.handleFetchTartuEmployeesResponseEvent(employeesList: (response)!)
        }
        
        self.handler.didRecieveErrorCallback = {response in
            weakSelf?.handleErrorResponseEvent(error: response!)
        }
    }
    
    // MARK: Data
    private func loadEmployees() {
        self.loadTallinnEmployees()
        self.loadTartuEmployees()
    }
    
    private func loadTallinnEmployees() {
        self.handler.requestFetchTallinnEmployeesDataAPI()
    }
    
    private func loadTartuEmployees() {
        self.handler.requestFetchTartuEmployeesDataAPI()
    }

    // MARK: Events
    
    // MARK: Network
    private func handleFetchTallinnEmployeesResponseEvent(employeesList: MCEmployeesListRootObject) {
        self.allEmployees = self.allEmployees + employeesList.employees
        
        if NetworkOperationQueue.sharedInstance.operations.count == 0 {
            self.handleFinishFetchingEmployeesEvent()
        }
    }
    
    private func handleFetchTartuEmployeesResponseEvent(employeesList: MCEmployeesListRootObject) {
        self.allEmployees = self.allEmployees + employeesList.employees
        
        if NetworkOperationQueue.sharedInstance.operations.count == 0 {
            self.handleFinishFetchingEmployeesEvent()
        }
    }

    private func handleErrorResponseEvent(error: Error) {
        
    }
    
    // MARK: Integration
    private func handleFinishFetchingEmployeesEvent() {
        self.handleIntegrateEmployeesDataEvent()
    }
    
    private func handleIntegrateEmployeesDataEvent() {
        let sortedEmployees = Dictionary(grouping: self.allEmployees, by: { $0.position }).sorted{$0.0 < $1.0}

        self.employeesTableViewDelegateDatasource?.employeesList = sortedEmployees
        
        self.employeesListView.employeesListTableView.reloadData()
    }
}

