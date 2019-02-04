//
//  ApplicationStrings.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 2/3/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation

extension String {
    var rawString: String {
        let simple = folding(options: [.diacriticInsensitive, .widthInsensitive, .caseInsensitive], locale: nil)
        
        let nonAlphaNumeric = CharacterSet.alphanumerics.inverted
        
        return simple.components(separatedBy: nonAlphaNumeric).joined(separator: "")
    }
}
