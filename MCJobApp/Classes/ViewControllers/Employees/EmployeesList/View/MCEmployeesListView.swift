//
//  MCEmployeesListView.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/25/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation
import UIKit

class MCEmployeesListView: UIView {
    // MARK: Outlets
    @IBOutlet weak var employeesListTableView: UITableView!
    
    @IBOutlet weak var refreshView: UIView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var refreshViewTopConstraint: NSLayoutConstraint!

    //MARK: Callbacks

    // MARK: Overriden methods
    override func awakeFromNib() {
        self.configureView()
    }
    
    //MARK: Private methods
    private func configureView() {
    }
    
    // MARK: Action Methods
    
    // MARK: Events
}
