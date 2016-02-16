//
//  QiitaAPIState.swift
//  ReSwiftTest
//
//  Created by oyuk on 2/14/16.
//  Copyright © 2016 okysoft. All rights reserved.
//

import Foundation

struct QiitaAPIState {
    var sarchResults: Result<[Post]>?
}

protocol HasQiitaAPIState {
    var qiitaAPIState: QiitaAPIState { get set }
}
