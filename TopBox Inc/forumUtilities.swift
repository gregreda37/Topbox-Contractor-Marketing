//
//  forumUtilities.swift
//  TopBox Inc
//
//  Created by Gregory Reda on 8/14/19.
//  Copyright © 2019 TopBox Inc. All rights reserved.
//

import Foundation
import UIKit

class forumUtilites{
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    
}
