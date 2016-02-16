//
//  AppState.swift
//  ReSwiftTest
//
//  Created by oyuk on 2/13/16.
//  Copyright © 2016 okysoft. All rights reserved.
//

import Foundation
import SwiftFlow
import SwiftFlowRouter

struct AppState: StateType,HasNavigationState,HasQiitaAPIState,HasQiitaSceneState {
    var navigationState = NavigationState()
    var qiitaAPIState = QiitaAPIState()
    var qiitaSceneState = SearchQiitaScene.State()
    
    init() {

    }
}