//
//  Result.swift
//  ReSwiftTest
//
//  Created by oyuk on 2/14/16.
//  Copyright © 2016 okysoft. All rights reserved.
//

import Foundation


enum ReError: String, ErrorType {
    case InvalidURLError = "InvalidURLError"
    case ConnectionError = "ConnectionError"
    case DeserializationError = "DeserializationError"
}

protocol ResultType {
    typealias Type
    
    init(value:Type)
    init(error:ReError)

}

enum Result<T>: ResultType {
    typealias Type = T
    
    case Success(Type)
    case Error(ReError)
    
    init(value: Type) {
        self = .Success(value)
    }
    
    init(error:ReError) {
        self = .Error(error)
    }
}