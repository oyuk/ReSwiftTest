//
//  QiitaAPIActionCreator.swift
//  ReSwiftTest
//
//  Created by oyuk on 2/14/16.
//  Copyright © 2016 okysoft. All rights reserved.
//

import Foundation
import SwiftFlow
import RxSwift

struct QiitaAPIActionCreator{
    
    func searchPosts(query:String)->ActionCreator {
        return {state,store in
            if query.isEmpty {
                store.dispatch(SetPostSearchResult(Result(value: [])))
                return nil
            }

            APIClient.search(query){result in
                store.dispatch(SetPostSearchResult(result))
            }
            
            return nil
        }
    }
}
