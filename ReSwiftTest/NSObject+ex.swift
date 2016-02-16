//
//  NSObject+ex.swift
//  ReSwiftTest
//
//  Created by oyuk on 2/14/16.
//  Copyright © 2016 okysoft. All rights reserved.
//

import Foundation

extension NSObject {
    class var className: String {
        get {
            return NSStringFromClass(self).componentsSeparatedByString(".").last!
        }
    }
    
    var className: String {
        get {
            return self.dynamicType.className
        }
    }
}