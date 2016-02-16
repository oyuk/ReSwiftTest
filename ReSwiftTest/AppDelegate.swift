////
//  AppDelegate.swift
//  ReSwiftTest
//
//  Created by oyuk on 2/13/16.
//  Copyright © 2016 okysoft. All rights reserved.
//

import UIKit
import SwiftFlow
import SwiftFlowRouter


let mainStore:MainStore = MainStore(reducer:CombinedReducer([NavigationReducer(),QiitaAPIReducer(),SearchQiitaScene._Reducer()]), appState: AppState(), middleware: [loggingMiddleware])

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: Router!
    var rootViewController: Routable!
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewControllerWithIdentifier(ViewController.identifier) as! ViewController
        
        rootViewController = vc
        
        router = Router(store: mainStore, rootRoutable: RootRoutable(routable: rootViewController))
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        mainStore.subscribe(self)
        
        mainStore.dispatch { state, store in
            if let state = state as? HasNavigationState where
                state.navigationState.route == [] {
                    return SetRouteAction([ViewController.identifier])
            } else {
                return nil
            }
        }
        
        return true
    }
    
}

extension AppDelegate: StoreSubscriber {
    func newState(maybeState: StateType) {}
}

class RootRoutable: Routable {
    
    var routable: Routable
    
    init(routable: Routable) {
        self.routable = routable
    }
    
    func pushRouteSegment(routeElementIdentifier: RouteElementIdentifier,
        completionHandler: RoutingCompletionHandler) -> Routable {
            completionHandler()
            return routable
    }
    
    func popRouteSegment(routeElementIdentifier: RouteElementIdentifier,
        completionHandler: RoutingCompletionHandler) {
            completionHandler()
    }
    
}