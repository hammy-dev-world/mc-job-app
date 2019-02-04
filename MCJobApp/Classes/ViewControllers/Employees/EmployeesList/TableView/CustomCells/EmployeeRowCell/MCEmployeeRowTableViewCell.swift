//
//  MCEmployeeRowTableViewCell.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/25/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import UIKit
import ContactsUI

class MCEmployeeRowTableViewCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!

    @IBOutlet weak var callButton: UIButton!

    @IBOutlet weak var emailAddressConstraint: NSLayoutConstraint!

    // MARK: Members
    public var row: Int!
    
    public var employeeRootObject: MCEmployeeRootObject!
    public var phoneContactRootObject: CNContact!

    // MARK: Callbacks
    public var didTapCallButtonCallback : ((_ phoneContactRootObject: CNContact) -> Void)?

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
        
        self.firstNameLabel.textColor = UIColor.darkTextColor()
        self.phoneNumberLabel.textColor = UIColor.darkTextColor()
        self.emailAddressLabel.textColor = UIColor.darkTextColor()
        
        self.callButton.setTitleColor(UIColor.darkTextColor(), for: .normal)
        self.callButton.configure(backgroundColor: .clear, borderColor: UIColor.darkButtonBorderColor(), textColor: UIColor.darkTextColor(), shouldLeftPad: false, target: self, action: #selector(callButtonTapped))
    }
    
    // MARK: Content
    private func setContent() {
        self.firstNameLabel.text = self.employeeRootObject.firstName + " " + self.employeeRootObject.lastName
        
        self.phoneNumberLabel.text = self.employeeRootObject.contactDetails.phoneNumber
        self.emailAddressLabel.text = self.employeeRootObject.contactDetails.emailAddress
    }
    
    // MARK: Images
    private func setImages() {
    }
    
    // MARK: View
    private func setView() {
        if self.employeeRootObject.contactDetails.phoneNumber.count == 0 {
            self.emailAddressConstraint.constant = 0.0
        } else {
            self.emailAddressConstraint.constant = 5.0
        }
        
        self.layoutIfNeeded()
    }
    
    // MARK: Action Methods
    @objc func callButtonTapped() {
        self.handleCallButtonTapEvent()
    }

    // MARK: Event Methods
    // MARK: User Actions
    private func handleCallButtonTapEvent() {
        if didTapCallButtonCallback != nil {
            didTapCallButtonCallback!(self.phoneContactRootObject)
        }
    }

    // MARK: Public methods
    // MARK: Data
    public func setEmployee(employeeRootObject: MCEmployeeRootObject, phoneContactRootObject: CNContact, row: Int) {
        self.employeeRootObject = employeeRootObject
        
        self.phoneContactRootObject = phoneContactRootObject
        
        self.row = row
        
        self.setContent()
        self.setImages()
        self.setView()
    }

}
