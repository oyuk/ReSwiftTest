//
//  ViewController.swift
//  ReSwiftTest
//
//  Created by oyuk on 2/13/16.
//  Copyright © 2016 okysoft. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SwiftFlow
import SwiftFlowRouter

class ViewController:UIViewController {
    
    static let identifier = "ViewController"
    private let cellIdentifier = QiitaPostTableViewCell.className
    
    private let store:Store = mainStore
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let qiitaActionCreator = QiitaAPIActionCreator()
    private var posts:[Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        searchBar.rx_text
            .filter{$0.characters.count > 0}
            .throttle(0.7, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribeNext {[unowned self](query) -> Void in
                print(query)
                self.searchBar.endEditing(true)
                self.store.dispatch(self.qiitaActionCreator.searchPosts(query))
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            }.addDisposableTo(disposeBag)

    }
    
}

extension ViewController:StoreSubscriber {
    
    func newState(state:AppState){
        if let searchResults = state.qiitaAPIState.sarchResults {
            switch searchResults {
            case .Success(let posts):
                self.posts = posts
                dispatch_async(dispatch_get_main_queue(), {[unowned self]() -> Void in
                    self.tableView.reloadData()
                    })
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            case .Error(let error):
                print(error)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self)
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! QiitaPostTableViewCell
        cell.post = posts[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
         (cell as! QiitaPostTableViewCell).profileImageView.kf_cancelDownloadTask()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let post = posts[indexPath.row]
        store.dispatch(SearchQiitaScene.SetSelectedPost(post))
        store.dispatch(pushRouteSegement(SecondViewController.identifier))
    }

}

extension ViewController: Routable{
    func pushRouteSegment(routeElementIdentifier: RouteElementIdentifier, completionHandler: RoutingCompletionHandler) -> Routable {
        if routeElementIdentifier == SecondViewController.identifier {
            let sv = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(routeElementIdentifier) as! SecondViewController
            
            let qiitaSceneState = store.appState as! HasQiitaSceneState
            if let selectedPost = qiitaSceneState.qiitaSceneState.selectedPost {
                sv.post = selectedPost
            }
            
            presentViewController(sv, animated: true, completion: nil)
            
            return sv as Routable
        }
        abort()
    }
    
}

