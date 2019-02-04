//
//  MCEmployeesListViewController.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/25/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import UIKit
import ContactsUI

struct EmployeesListViewControllerConstants {
    static let kRefreshEmployeeAnimationTime = 5.0
}

class MCEmployeesListViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var employeesListView: MCEmployeesListView!

    // MARK: Instance Variables
    var employeesTableViewDelegateDatasource: MCEmployeesListTableViewDelegateDatasource?

    var handler: MCEmployeesListHandler!

    var allEmployees: [MCEmployeeRootObject]! = []
    
    var allContacts: [CNContact]! = []

    var contactStore: CNContactStore = CNContactStore()

    var refreshControl: UIRefreshControl!

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureHandler()
        self.configureObjects()
        self.configureTableView()
        self.configureRefreshControl()
        self.configureCallbacks()
        
        self.loadEmployees()
        self.loadDeviceContacts()
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
        self.employeesListView.employeesListTableView.estimatedRowHeight = CGFloat(EmployeesListTableViewConstants.kHeightForEmployeeRowCell)

        
        self.employeesListView.employeesListTableView.register(UINib(nibName: ApplicationInterfaceFilenames.kEmployeeGroupTableViewCell, bundle: nil), forCellReuseIdentifier: ApplicationInterfaceFilenames.kEmployeeGroupTableViewCell)
        self.employeesListView.employeesListTableView.register(UINib(nibName: ApplicationInterfaceFilenames.kEmployeeRowTableViewCell, bundle: nil), forCellReuseIdentifier: ApplicationInterfaceFilenames.kEmployeeRowTableViewCell)
    }
    
    // MARK: Refresh Control
    private func configureRefreshControl() {
        self.refreshControl = UIRefreshControl()
        
        if #available(iOS 10.0, *) {
            self.employeesListView.employeesListTableView.refreshControl = self.refreshControl
        } else {
            self.employeesListView.employeesListTableView.addSubview(self.refreshControl)
        }
        
        self.refreshControl.addTarget(self, action:#selector(refreshControlPulled), for: .valueChanged)
    }

    // MARK: Callbacks
    private func configureCallbacks() {
        weak var weakSelf = self
        
        self.employeesTableViewDelegateDatasource?.didTapEmployeeRowCallback = {employee, contacts in
            weakSelf?.handleEmployeeRowTapEvent(employee: employee as MCEmployeeRootObject, contacts: contacts as [CNContact])
        }
        
        self.employeesTableViewDelegateDatasource?.didTapCallButtonCallback = {phoneContact in
            weakSelf?.handleEmployeeCallTapEvent(phoneContactObject: phoneContact as CNContact)
        }
        
        self.handler.didReceiveSuccessFetchingDeviceContactsCallback = {contacts in
            weakSelf?.handleDeviceContactFetchingSuccessResponseEvent(contacts: contacts!)
        }
        
        self.handler.didRecieveFetchingContactErrorCallback = {error in
            weakSelf?.handleDeviceContactFetchingErrorResponseEvent(error: error!)
        }
        
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
    // MARK: Local
    private func loadDeviceContacts() {
        self.handler.requestFetchDeviceContactsDataRequest()
    }

    // MARK: Remote
    private func loadEmployees() {
        self.handleChangeActivityIndicatorState(startAnimating: true)
        
        self.loadTallinnEmployees()
        self.loadTartuEmployees()
    }
    
    private func loadTallinnEmployees() {
        self.handler.requestFetchTallinnEmployeesDataAPI()
    }
    
    private func loadTartuEmployees() {
        self.handler.requestFetchTartuEmployeesDataAPI()
    }

    private func refreshEmployees() {
        self.showRefreshEmployeesListView()
        
        self.allEmployees = [MCEmployeeRootObject]()

        self.loadEmployees()
        self.loadDeviceContacts()
    }
    
    // MARK: Instance Methods
    private func showRefreshEmployeesListView() {
        self.employeesListView.refreshViewTopConstraint.constant = -(self.employeesListView.refreshView.frame.height)
        
        UIView.animate(withDuration: EmployeesListViewControllerConstants.kRefreshEmployeeAnimationTime, animations: {
            self.employeesListView.refreshViewTopConstraint.constant = 0
        }, completion: nil)
    }
    
    private func hideRefreshEmployeesListView() {
        self.employeesListView.refreshViewTopConstraint.constant = 0
        
        UIView.animate(withDuration: EmployeesListViewControllerConstants.kRefreshEmployeeAnimationTime, animations: {
            self.employeesListView.refreshViewTopConstraint.constant =  -(self.employeesListView.refreshView.frame.height)
        }, completion: nil)
    }

    // MARK: Events
    // MARK: User Actions
    private func handleEmployeeRowTapEvent(employee: MCEmployeeRootObject, contacts: [CNContact]) {
        let employeeProfileViewController = MCEmployeeProfileViewController(nibName: ApplicationInterfaceFilenames.kEmployeeProfileViewController, bundle: nil)
        
        employeeProfileViewController.employee = employee
        employeeProfileViewController.contacts = contacts
        
        self.navigationController?.pushViewController(employeeProfileViewController, animated: true)
    }
    
    private func handleEmployeeCallTapEvent(phoneContactObject: CNContact) {
        var contact = phoneContactObject
        
        if !contact.areKeysAvailable([CNContactViewController.descriptorForRequiredKeys()]) {
            do {
                contact = try self.contactStore.unifiedContact(withIdentifier: contact.identifier, keysToFetch: [CNContactViewController.descriptorForRequiredKeys()])
            } catch {
                
            }
        }
        
        let contactViewController = MCContactViewController(for: contact)
        
        self.navigationController?.pushViewController(contactViewController, animated: false)
    }
    
    private func handleChangeActivityIndicatorState(startAnimating: Bool) {
        if startAnimating == true {
            self.employeesListView.activityIndicator.isHidden = false
            self.employeesListView.activityIndicator.startAnimating()
        } else {
            self.employeesListView.activityIndicator.isHidden = true
            self.employeesListView.activityIndicator.stopAnimating()
        }
    }
    
    @objc func refreshControlPulled() {
        self.refreshEmployees()
    }

    // MARK: Network
    private func handleDeviceContactFetchingSuccessResponseEvent(contacts: [CNContact]) {
        self.handleChangeActivityIndicatorState(startAnimating: false)
        
        self.allContacts = contacts
    }
    
    private func handleDeviceContactFetchingErrorResponseEvent(error: Error) {
        self.refreshControl.endRefreshing()

        self.handleChangeActivityIndicatorState(startAnimating: false)
    }

    private func handleFetchTallinnEmployeesResponseEvent(employeesList: MCEmployeesListRootObject) {        
        self.allEmployees = self.allEmployees + employeesList.employees
        
        if MCOperationQueue.sharedInstance.operations.count == 0 {
            self.handleFinishFetchingEmployeesEvent()
        }
    }
    
    private func handleFetchTartuEmployeesResponseEvent(employeesList: MCEmployeesListRootObject) {
        self.allEmployees = self.allEmployees + employeesList.employees
        
        if MCOperationQueue.sharedInstance.operations.count == 0 {
            self.handleFinishFetchingEmployeesEvent()
        }
    }

    private func handleErrorResponseEvent(error: Error) {
        self.refreshControl.endRefreshing()

        self.handleChangeActivityIndicatorState(startAnimating: false)
    }
    
    // MARK: Integration
    private func handleFinishFetchingEmployeesEvent() {
        self.handleIntegrateEmployeesDataEvent()
    }
    
    private func handleIntegrateEmployeesDataEvent() {
        self.handleChangeActivityIndicatorState(startAnimating: false)

        self.loadDeviceContacts()

        self.refreshControl.endRefreshing()

        self.hideRefreshEmployeesListView()
        
        self.allEmployees = self.allEmployees.unique{$0.firstName + " " + $0.lastName}.sorted(by: {$0.lastName < $1.lastName})

        let sortedEmployees = Dictionary(grouping: self.allEmployees, by: { $0.position }).sorted{$0.0 < $1.0}

        self.employeesTableViewDelegateDatasource?.employeesList = sortedEmployees
        self.employeesTableViewDelegateDatasource?.contactList = self.allContacts

        DispatchQueue.main.async {
            self.employeesListView.employeesListTableView.reloadData()
        }
    }
}
