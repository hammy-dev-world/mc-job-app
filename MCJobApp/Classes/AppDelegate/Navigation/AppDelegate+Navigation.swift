//
//  AppDelegate+Navigation.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/25/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {
    // MARK: Init
    func initWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
    }
    
    // MARK: Private methods
    // MARK: Navigation Bar Appearance
    private func initializeAppNavigationBarAppearance(viewController: UIViewController) -> UINavigationController{
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.navigationBar.isTranslucent = false
        navigationController.isNavigationBarHidden = true
        
        return navigationController
    }
    
    // MARK: Public methods
    
    // MARK: Session handling
    
    // MARK: Navigation Stacks
    // MARK: Employees
    public func moveToEmployeesParentNavigationStack() {
        self.moveToEmployeesListViewController()
    }
    
    public func moveToEmployeesListViewController() {
        let employeesListViewController = MCEmployeesListViewController(nibName: ApplicationInterfaceFilenames.kEmployeesListViewController, bundle: nil)

        self.window?.rootViewController = self.initializeAppNavigationBarAppearance(viewController: employeesListViewController)
    }
}
