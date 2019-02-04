//
//  MCEmployeeProfileHeaderTableViewCell.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 2/2/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import UIKit

class MCEmployeeProfileHeaderTableViewCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

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
        self.backgroundColor = UIColor.employeeRowBackgroundColor()

        self.nameLabel.textColor = UIColor.darkTextColor()
        self.locationLabel.textColor = UIColor.darkTextColor()

    }
    
    // MARK: Content
    private func setContent() {
        self.nameLabel.text = self.employeeRootObject.firstName + " " + self.employeeRootObject.lastName 
        
        self.locationLabel.text =  self.employeeRootObject.location

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
