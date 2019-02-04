//
//  ApplicationBarButtonItems.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 2/2/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    class func barButton(image: UIImage?, frame: CGRect, target: AnyObject, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.frame = frame
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
}
