//
//  MCEmployeeProfileSectionTableViewCell.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 2/2/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import UIKit
import ContactsUI

class MCEmployeeCallSectionTableViewCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var callButton: UIButton!

    // MARK: Members
    public var row: Int!
    
    public var employeeRootObject: MCEmployeeRootObject!

    // MARK: Callbacks
    public var didTapCallButtonCallback : ((_ phoneContactRootObject: CNContact) -> Void)?
    public var phoneContactRootObject: CNContact!

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

        self.callButton.setTitleColor(.white, for: .normal)
        self.callButton.configure(backgroundColor: .darkButtonBackgroundColor(), borderColor: .darkButtonBackgroundColor(), textColor: .white, shouldLeftPad: false, target: self, action: #selector(callButtonTapped))
    }
    
    // MARK: Content
    private func setContent() {

    }
    
    // MARK: Images
    private func setImages() {
    }
    
    // MARK: View
    private func setView() {

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
