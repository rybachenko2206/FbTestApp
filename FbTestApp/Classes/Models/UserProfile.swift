//
//  UserProfile.swift
//  FbTestApp
//
//  Created by Roman Rybachenko on 2/3/17.
//  Copyright © 2017 Roman Rybachenko. All rights reserved.
//


import SwiftyJSON
import FacebookCore

import Foundation


let kFirstName = "first_name"
let kLastName = "last_name"
let kName = "name"
let kId = "id"
let kPicture = "picture"
let kData = "data"
let kUrl = "url"
let kCover = "cover"
let kGender = "gender"
let kSource = "source"

typealias completion = (_ success: Bool, _ error: Error?) -> Void


class UserProfile: GraphRequestProtocol {
    
    var response: Response?
    
    struct Response: GraphResponseProtocol {
        
        private(set) public var name: String = ""
        private(set) public var firstName: String = ""
        private(set) public var lastName: String = ""
        private(set) public var userId: String = ""
        private(set) public var avatarLink: String = ""
        private(set) public var coverLink: String = ""
        private(set) public var gender: String = ""
        
        private(set) public var location: AnyObject?
        private(set) public var hometown: String?
        private(set) public var birthday: AnyObject?
        
        init(rawResponse: Any?) {
            let json = JSON.init(rawResponse!)
            print("\n~~response json = \n\(json)")
            
            self.name = json[kName].stringValue
            self.firstName = json[kFirstName].stringValue
            self.lastName = json[kLastName].stringValue
            self.userId = json[kId].stringValue
            self.avatarLink = json[kPicture][kData][kUrl].stringValue
            self.coverLink = json[kCover][kSource].stringValue
            self.gender = json[kGender].stringValue
            
            // TODO: resolve getting params: location, hometown, birthday
        }
    }
    
    var graphPath = "/me"
    var parameters: [String : Any]? = ["fields": "id, name, first_name, birthday, location, last_name, gender, hometown, picture.type(large), cover.type(large)"]
    var accessToken = AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = .defaultVersion
    
    func getProfile(completion: @escaping completion) {
        let connection = GraphRequestConnection()
        connection.add(UserProfile()) { response, result in
            switch result {
            case .success(let response):
                print("~~Custom Graph Request Succeeded: \(response)")
                self.response = response
                completion(true, nil)
                
            case .failed(let error):
                print("~~Custom Graph Request Failed: \(error)")
                completion(false, error)
            }
        }
        connection.start()
    }
}
