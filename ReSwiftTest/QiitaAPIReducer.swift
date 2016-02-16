//
//  QiitaAPIReducer.swift
//  ReSwiftTest
//
//  Created by oyuk on 2/14/16.
//  Copyright © 2016 okysoft. All rights reserved.
//

import Foundation
import SwiftFlow

struct QiitaAPIReducer:Reducer{
    
    typealias ReducerStateType = HasQiitaAPIState
    
    func handleAction(state: ReducerStateType, action: Action) -> ReducerStateType {
        switch action {
        case let action as SetPostSearchResult:
            return setPostSearchResult(state, result: action.result)
        default:
            return state
        }
    }
    
    func setPostSearchResult(var state:ReducerStateType,result:Result<[Post]>)->ReducerStateType {
        state.qiitaAPIState.sarchResults = result
        return state
    }

}