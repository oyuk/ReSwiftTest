//
//  SecondViewController.swift
//  ReSwiftTest
//
//  Created by oyuk on 2/13/16.
//  Copyright © 2016 okysoft. All rights reserved.
//

import UIKit
import SwiftFlow
import SwiftFlowRouter

class SecondViewController:UIViewController {
    
    static let identifier = "SecondViewController"
    
    @IBOutlet weak var titleLabel: UILabel!
    var post:Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = post?.title
    }
    
}

extension SecondViewController:Routable {

}