//
//  UserProfile.swift
//  FbTestApp
//
//  Created by Roman Rybachenko on 2/3/17.
//  Copyright © 2017 Roman Rybachenko. All rights reserved.
//


import FacebookCore
import Foundation


class UserProfile: GraphRequestProtocol {
    struct Response: GraphResponseProtocol {
        init(rawResponse: Any?) {
            print("response type = \(rawResponse.debugDescription)")
            
        }
    }
    
    private(set) public var name: String?
    private(set) public var firstName: String?
    private(set) public var lastName: String?
    private(set) public var userId: AnyObject?
    private(set) public var email: String?
    private(set) public var avatarLink: String?
    
    var graphPath = "/me"
    var parameters: [String : Any]? = ["fields": "id, name, first_name, last_name, email, picture.type(large)"]
    var accessToken = AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = .defaultVersion
    
    func getProfile() {
        let connection = GraphRequestConnection()
        connection.add(UserProfile()) { response, result in
            switch result {
            case .success(let response):
                print("Custom Graph Request Succeeded: \(response)")
                //print("My facebook id is \(response.dictionaryValue?["id"])")
                //print("My name is \(response.dictionaryValue?["name"])")
            case .failed(let error):
                print("Custom Graph Request Failed: \(error)")
            }
        }
        connection.start()
    }
}
