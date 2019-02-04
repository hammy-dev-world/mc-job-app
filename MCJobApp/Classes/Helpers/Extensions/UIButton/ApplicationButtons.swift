//
//  ApplicationButtons.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 2/3/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    func configure(backgroundColor: UIColor, borderColor: UIColor, textColor: UIColor, shouldLeftPad: Bool, target: AnyObject, action: Selector) -> Void {
        self.backgroundColor = backgroundColor
        
        self.setTitleColor(textColor, for: .normal)
        
        self.layer.borderColor = borderColor.cgColor
        
        self.layer.masksToBounds = true
        
        self.addTarget(target, action: action, for: .touchUpInside)
    }    
}
