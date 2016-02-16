//
//  QiitaClient.swift
//  ReSwiftTest
//
//  Created by oyuk on 2/14/16.
//  Copyright © 2016 okysoft. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa
import ObjectMapper

protocol Client {
    typealias Type
    static var endPoint:String {get}
    static func call(query:String,handler:Result<[Type]>->Void)
    static func responseFromData(data:NSData)->Result<[Type]>
}

struct APIClient:Client {
    typealias Type = Post
    
    static let endPoint:String = "https://qiita.com/api/v1/"
    
    static func call(query:String,handler:Result<[Type]>->Void) {
        guard let url = NSURL(string: endPoint + query) else {
            handler(Result(error: .InvalidURLError))
            return
        }
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task    = session.dataTaskWithURL(url, completionHandler: {
            (data, response, error) in
            
            guard let data = data else {
                handler(Result(error: .ConnectionError))
                return
            }

            handler(responseFromData(data))
        })
        
        task.resume()
    }
    
    static func responseFromData(data:NSData) -> Result<[Post]> {
        let json:AnyObject
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data ?? NSData(), options: [])
        } catch {
            return Result(error: .DeserializationError)
        }
        
        guard let dictonary = json as? [[String: AnyObject]] else {
            return Result(error: .DeserializationError)
        }
        
        return Result(value: Type.ArrayFromJson(dictonary))
    }
}

extension APIClient {
    static func search(keyword:String,handler:Result<[Type]>->Void) {
        call("search?q=\(keyword)",handler: handler)
    }
}
