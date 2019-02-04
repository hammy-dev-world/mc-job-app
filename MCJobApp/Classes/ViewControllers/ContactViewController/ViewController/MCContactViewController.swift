//
//  MCContactViewController.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 2/3/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation
import ContactsUI

class MCContactViewController: CNContactViewController {
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
        
        self.title = ApplicationNavigationTitles.kEmployeeContactViewNavigationTitle
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(image: UIImage(named: ApplicationResourceFilenames.kNavigationBackButton), frame: CGRect(x: 0, y: 0, width: CGFloat(ApplicationNumberConstants.kLeftBarButtonWidth), height: CGFloat(ApplicationNumberConstants.kLeftBarButtonHeight)), target: self, action:#selector(backButtonTapped))
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
}
