//
//  MCEmployeeProfileViewController.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 2/2/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import UIKit
import ContactsUI

class MCEmployeeProfileViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var employeesProfileView: MCEmployeeProfileView!

    // MARK: Instance Variables
    public var employee: MCEmployeeRootObject?

    public var contacts: [CNContact]?

    var employeeProfileTableViewDelegateDatasource: MCEmployeeProfileTableViewDelegateDatasource?

    var handler: MCEmployeeProfileHandler!

    var contactStore: CNContactStore = CNContactStore()

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureHandler()
        self.configureObjects()
        self.configureTableView()
        self.configureCallbacks()
        
        self.loadEmployeeData()
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
        
        self.title = ApplicationNavigationTitles.kEmployeeProfileNavigationTitle
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(image: UIImage(named: ApplicationResourceFilenames.kNavigationBackButton), frame: CGRect(x: 0, y: 0, width: CGFloat(ApplicationNumberConstants.kLeftBarButtonWidth), height: CGFloat(ApplicationNumberConstants.kLeftBarButtonHeight)), target: self, action:#selector(backButtonTapped))
    }

    // MARK: Handler
    private func configureHandler() -> Void{
        self.handler = MCEmployeeProfileHandler(viewController: self)
    }
    
    // MARK: Objects
    private func configureObjects() {
        self.employeeProfileTableViewDelegateDatasource = MCEmployeeProfileTableViewDelegateDatasource()
    }

    // MARK: Table View
    private func configureTableView() {
        self.employeesProfileView.employeeProfileTableView.delegate = self.employeeProfileTableViewDelegateDatasource
        self.employeesProfileView.employeeProfileTableView.dataSource = self.employeeProfileTableViewDelegateDatasource
        self.employeesProfileView.employeeProfileTableView.estimatedRowHeight = CGFloat(EmployeeProfileTableViewConstants.kHeightForEmployeeHeaderCell)

        
        self.employeesProfileView.employeeProfileTableView.register(UINib(nibName: ApplicationInterfaceFilenames.kEmployeeProfileHeaderTableViewCell, bundle: nil), forCellReuseIdentifier: ApplicationInterfaceFilenames.kEmployeeProfileHeaderTableViewCell)
        self.employeesProfileView.employeeProfileTableView.register(UINib(nibName: ApplicationInterfaceFilenames.kEmployeeProfileSectionTableViewCell, bundle: nil), forCellReuseIdentifier: ApplicationInterfaceFilenames.kEmployeeProfileSectionTableViewCell)

        self.employeesProfileView.employeeProfileTableView.register(UINib(nibName: ApplicationInterfaceFilenames.kEmployeeCallSectionTableViewCell, bundle: nil), forCellReuseIdentifier: ApplicationInterfaceFilenames.kEmployeeCallSectionTableViewCell)
    }
    
    // MARK: Callbacks
    private func configureCallbacks() {
        weak var weakSelf = self
        
        self.employeeProfileTableViewDelegateDatasource?.didTapCallButtonCallback = {phoneContact in
            weakSelf?.handleEmployeeCallTapEvent(phoneContactObject: phoneContact as CNContact)
        }

        
    }
    
    // MARK: Data
    private func loadEmployeeData() {
        self.handleIntegrateEmployeeDataEvent()
    }
    
    // MARK: Action Methods
    @objc func backButtonTapped() {
        self.handleBackButtonTapEvent()
    }
    
    // MARK: Events
    // MARK: User Actions
    private func handleBackButtonTapEvent() {
        self.navigationController?.popViewController(animated: true)
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

    // MARK: Network
    // MARK: Integration
    private func handleIntegrateEmployeeDataEvent() {
        self.employeeProfileTableViewDelegateDatasource?.employee = self.employee!
        self.employeeProfileTableViewDelegateDatasource?.contacts = self.contacts!
    
        self.employeesProfileView.employeeProfileTableView.reloadData()
    }
}

