//
//  MCEmployeeProfileView.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 2/2/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation
import UIKit

class MCEmployeeProfileView: UIView {
    // MARK: Outlets
    @IBOutlet weak var employeeProfileTableView: UITableView!

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
