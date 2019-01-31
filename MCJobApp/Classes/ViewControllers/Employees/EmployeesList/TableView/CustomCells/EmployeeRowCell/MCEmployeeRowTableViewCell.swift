//
//  MCEmployeeRowTableViewCell.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/25/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import UIKit

class MCEmployeeRowTableViewCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var firstNameLabel: UILabel!

    // MARK: Members
    public var row: Int!
    
    public var employeeRootObject: MCEmployeeRootObject!

    // MARK: Callbacks

    // MARK: Init methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Configurations
        self.configureView()
    }

    // MARK: Private methods
    // MARK: View
    private func configureView() {
    }
    
    // MARK: Content
    private func setContent() {
        self.firstNameLabel.text = self.employeeRootObject.firstName + " " + self.employeeRootObject.lastName
    }
    
    // MARK: Images
    private func setImages() {
    }
    
    // MARK: View
    private func setView() {
        
    }
    
    // MARK: Action Methods
    
    // MARK: Event Methods
    
    // MARK: Public methods
    // MARK: Data
    public func setEmployee(employeeRootObject: MCEmployeeRootObject, row: Int) {
        self.employeeRootObject = employeeRootObject
        
        self.row = row
        
        self.setContent()
        self.setImages()
        self.setView()
    }

}
