//
//  ApplicationArrays.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 2/3/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import UIKit
import Foundation

extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>()
        var arrayOrdered = [Element]() 
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        
        return arrayOrdered
    }
}
