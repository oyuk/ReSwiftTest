//
//  Post.swift
//  ReSwiftTest
//
//  Created by oyuk on 2/14/16.
//  Copyright © 2016 okysoft. All rights reserved.
//

import Foundation
import ObjectMapper

//
//	RootClass.swift
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Post : Mappable{
    
    var body : String?
    var commentCount : Int?
    var createdAt : String?
    var createdAtAsSeconds : Int?
    var createdAtInWords : String?
    var gistUrl : AnyObject?
    var id : Int?
    var privateField : Bool?
    var rawBody : String?
    var stockCount : Int?
    var stockUsers : [String]?
    var tags : [Tag]?
    var title : String?
    var tweet : Bool?
    var updatedAt : String?
    var updatedAtInWords : String?
    var url : String?
    var user : User?
    var uuid : String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map)
    {
        body <- map["body"]
        commentCount <- map["comment_count"]
        createdAt <- map["created_at"]
        createdAtAsSeconds <- map["created_at_as_seconds"]
        createdAtInWords <- map["created_at_in_words"]
        gistUrl <- map["gist_url"]
        id <- map["id"]
        privateField <- map["private"]
        rawBody <- map["raw_body"]
        stockCount <- map["stock_count"]
        stockUsers <- map["stock_users"]
        tags <- map["tags"]
        title <- map["title"]
        tweet <- map["tweet"]
        updatedAt <- map["updated_at"]
        updatedAtInWords <- map["updated_at_in_words"]
        url <- map["url"]
        user <- map["user"]
        uuid <- map["uuid"]
        
    }
}

extension Post {
    static func ArrayFromJson(json:[[String:AnyObject]])->[Post] {
        return json.flatMap { (response) -> Post? in
            guard let post = Mapper<Post>().map(response) else {
                return nil
            }
            return post
        }
    }
}