//
//  User.swift
//  ReSwiftTest
//
//  Created by oyuk on 2/14/16.
//  Copyright © 2016 okysoft. All rights reserved.
//

import Foundation
import ObjectMapper

//
//	User.swift
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class User : Mappable{
    
    var id : Int?
    var profileImageUrl : String?
    var urlName : String?
    
    required init?(_ map: Map) {

    }
    
    func mapping(map: Map)
    {
        id <- map["id"]
        profileImageUrl <- map["profile_image_url"]
        urlName <- map["url_name"]
        
    }
    
}