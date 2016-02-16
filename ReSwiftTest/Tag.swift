//
//  Tag.swift
//  ReSwiftTest
//
//  Created by oyuk on 2/14/16.
//  Copyright © 2016 okysoft. All rights reserved.
//

import Foundation
import ObjectMapper

//
//	Tag.swift
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport


class Tag : Mappable{
    
    var iconUrl : String?
    var name : String?
    var urlName : String?
    var versions : [AnyObject]?
    
    required init?(_ map: Map) {

    }   
    
    func mapping(map: Map)
    {
        iconUrl <- map["icon_url"]
        name <- map["name"]
        urlName <- map["url_name"]
        versions <- map["versions"]
        
    }
    
}