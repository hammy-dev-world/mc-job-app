//
//  MCEmployeeProfileSectionTableViewCell.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 2/2/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import UIKit

struct EmployeeProfileSectionConstants {
    static let kPhoneNumberTitleString = "Phone Number"
    static let kEmailAdressTitleString = "Email Address"
    static let kPositionTitleString = "Position"
    static let kProjectsTitleString = "Projects"
    
    static let kNotAvailableString = "Not Available"
}

class MCEmployeeProfileSectionTableViewCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var sectionHeaderLabel: UILabel!
    @IBOutlet weak var sectionContentLabel: UILabel!

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
        self.backgroundColor = .white

    }
    
    // MARK: Content
    private func setContent() {
        switch self.row {
        case 1:
            self.sectionHeaderLabel.text = EmployeeProfileSectionConstants.kPhoneNumberTitleString
            
            if self.employeeRootObject.contactDetails.phoneNumber.count == 0 {
                self.sectionContentLabel.text = EmployeeProfileSectionConstants.kNotAvailableString
            } else {
                self.sectionContentLabel.text = self.employeeRootObject.contactDetails.phoneNumber
            }
        case 2:
            self.sectionHeaderLabel.text = EmployeeProfileSectionConstants.kEmailAdressTitleString
            
            if self.employeeRootObject.contactDetails.emailAddress.count == 0 {
                self.sectionContentLabel.text = EmployeeProfileSectionConstants.kNotAvailableString
            } else {
                self.sectionContentLabel.text = self.employeeRootObject.contactDetails.emailAddress
            }
        case 3:
            self.sectionHeaderLabel.text = EmployeeProfileSectionConstants.kPositionTitleString
            
            if self.employeeRootObject.position.count == 0 {
                self.sectionContentLabel.text = EmployeeProfileSectionConstants.kNotAvailableString
            } else {
                self.sectionContentLabel.text = self.employeeRootObject.position
            }
        case 4:
            self.sectionHeaderLabel.text = EmployeeProfileSectionConstants.kProjectsTitleString
            
            if self.employeeRootObject.projects.count == 0 {
                self.sectionContentLabel.text = EmployeeProfileSectionConstants.kNotAvailableString
            } else {
                self.sectionContentLabel.text = self.employeeRootObject.projects.joined(separator: "\n")
            }
        default:
            self.sectionHeaderLabel.text = ""
        }

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
