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

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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


}

