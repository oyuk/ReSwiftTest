//
//  MiddleWare.swift
//  ReSwiftTest
//
//  Created by oyuk on 2/13/16.
//  Copyright © 2016 okysoft. All rights reserved.
//

import Foundation
import SwiftFlow

let loggingMiddleware: Middleware = { dispatch, getState in
    return { next in
        return { action in
            // perform middleware logic
            print(action)
            
            // call next middleware
            return next(action)
        }
    }
}