//
//  QiitaAPIActions.swift
//  ReSwiftTest
//
//  Created by oyuk on 2/14/16.
//  Copyright © 2016 okysoft. All rights reserved.
//

import Foundation
import SwiftFlow

struct SetPostSearchResult:Action {
    let result:Result<[Post]>
    init(_ result:Result<[Post]>) {
        self.result = result
    }
}
