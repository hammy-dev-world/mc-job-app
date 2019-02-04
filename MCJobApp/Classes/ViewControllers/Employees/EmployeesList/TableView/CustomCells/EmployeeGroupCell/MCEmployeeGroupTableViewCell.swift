//
//  MCEmployeeGroupTableViewCell.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/25/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import UIKit

class MCEmployeeGroupTableViewCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var positionHeaderLabel: UILabel!

    // MARK: Members
    public var positionGroupName: String!

    public var section: Int!
    
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
        self.backgroundColor = UIColor.employeeGroupBackgroundColor()
    }
    
    // MARK: Content
    private func setContent() {
        self.positionHeaderLabel.text = self.positionGroupName
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
    public func setPositionGroup(positionGroupName: String, section: Int) {
        self.positionGroupName = positionGroupName
        
        self.section = section
        
        self.setContent()
        self.setImages()
        self.setView()
    }

}
