[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) 
[![](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/Swift-Flow/Swift-Flow/blob/master/LICENSE.md)


A declarative router for [Swift Flow](https://github.com/Swift-Flow/Swift-Flow). Allows developers to declare routes in a similar manner as URLs are used on the web.

Using Swift Flow Router you can navigate your app by defining the target location in the form of a URL-like sequence of identifiers:

```swift
mainStore.dispatch(
    SetRouteAction(["TabBarViewController", StatsViewController.identifier])
)
```    

#About Swift Flow Router

**Swift Flow Router is still under development and the API is neither complete nor stable at this point.**

When building apps with Swift Flow you should aim to cause **all** state changes through actions - this includes changes to the navigation state.

This requires to store the current navigation state within the app state and to use actions to trigger changes to that state - both is provided Swift Flow Router.

#Installation

Install Swift Flow Router via Carthage:

```
github "Swift-Flow/Swift-Flow-Router"
```

#Configuration

Extend your app state to include the navigation state by conforming to the `HasNavigationState` protocol and adding the a `navigationState` member as follows:

```swift
import SwiftFlowRouter

struct AppState: StateType, HasNavigationState {
    // other application state
    var navigationState = NavigationState()
}
```

After you've initialized your store, create an instance of `Router`, passing in a reference to the store and to the root `Routable`:

```swift
router = Router(store: mainStore, rootRoutable: RootRoutable(routable: rootViewController))
```

We'll discuss `Routable` in the next section.

#Implementing `Routable`

Swift Flow Router works with routes that are defined, similar to URLs, as a sequence of identifiers e.g. `["Home", "User", "UserDetail"]`. 

Swift Flow Router is agnostic of the UI framework you are using - it uses `Routable`s to implement that interaction.

Each route segment is mapped to one responsible `Routable`. The `Routable` needs to be able to present a child, hide a child or replace a child with another child.

Here is the `Routable` protocol with the methods you should implement:

```swift
protocol Routable {

    func changeRouteSegment(from: RouteElementIdentifier,
        to: RouteElementIdentifier,
        completionHandler: RoutingCompletionHandler) -> Routable

    func pushRouteSegment(routeElementIdentifier: RouteElementIdentifier,
        completionHandler: RoutingCompletionHandler) -> Routable

    func popRouteSegment(routeElementIdentifier: RouteElementIdentifier,
        completionHandler: RoutingCompletionHandler)

}
```

As part of initializing `Router` you need to pass the first `Routable` as an argument. That root `Routable` will be responsible for the first route segment.

If e.g. you set the route of your application to `["Home"]`, your root `Routable` will be asked to present the view that corresponds to the identifier `"Home"`. 

When working on iOS with UIKit this would mean the `Routable` would need to set the `rootViewController` of the application.  

Whenever a `Routable` presents a new route segment, it needs to return a new `Routable` that will be responsible for managing the presented segment. If you want to navigate from `["Home"]` to `["Home", "Users"]` the `Routable` responsible for the `"Home"` segment will be asked to present the `"User"` segment.

If your navigation stack uses a modal presentation for this transition, the implementation of `Routable` for the `"Home"` segment might look like this:

```swift
func pushRouteSegment(identifier: RouteElementIdentifier,
    completionHandler: RoutingCompletionHandler) -> Routable {
    
	if identifier == "Home" {
		// 1.) Perform the transition
        userViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewControllerWithIdentifier("UserViewController") as! Routable

		// 2.) Call the `completionHandler` once the transition is complete
        presentViewController(userViewController, animated: false,
            completion: completionHandler)

		// 3.) Return the Routable for the presented segment. For convenience
		// this will often be the UIViewController itself. 
        return userViewController
   	}
   	
   	// ...
}

func popRouteSegment(identifier: RouteElementIdentifier,
    completionHandler: RoutingCompletionHandler) {

	if identifier == "Home" {
    	dismissViewControllerAnimated(false, completion: completionHandler)
    }
    
    // ...
}
```

##Calling the Completion Handler within Routables

Swift Flow Router needs to throttle the navigation actions, since many UI frameworks including UIKit don't allow to perform multiple navigation steps in parallel. Therefor every method of `Routable` receives a `completionHandler`. The router will not perform any further navigation actions until the completion handler is called.

#Changing the Current Route

Currently the only way to change the current application route is by using the `SetRouteAction` and providing an absolute route. Here's a brief example:

```swift
@IBAction func cancelButtonTapped(sender: UIButton) {
    mainStore.dispatch(
        SetRouteAction(["TabBarViewController", StatsViewController.identifier])
    )
}
```
As development continues, support for changing individual route segments will be added.
