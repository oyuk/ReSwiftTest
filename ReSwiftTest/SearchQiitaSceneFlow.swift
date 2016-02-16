//
//  SearchQiitaSceneFlow.swift
//  ReSwiftTest
//
//  Created by oyuk on 2/14/16.
//  Copyright © 2016 okysoft. All rights reserved.
//

import Foundation
import SwiftFlow

protocol HasQiitaSceneState {
    var qiitaSceneState: SearchQiitaScene.State { get set }
}

struct SearchQiitaScene {
    
    struct State {
        var selectedPost: Post?
    }

    struct SetSelectedPost: Action {
        var post: Post
        
        init(_ post: Post) {
            self.post = post
        }
    }
    
    struct _Reducer: Reducer {
        
        func handleAction(var state: HasQiitaSceneState, action: Action) -> HasQiitaSceneState {
            if let action = action as? SetSelectedPost {
                state.qiitaSceneState.selectedPost = action.post
                return state
            }
            
            return state
        }
        
    }
    
}
