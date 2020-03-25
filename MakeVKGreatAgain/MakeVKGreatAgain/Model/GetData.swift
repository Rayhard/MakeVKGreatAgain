//
//  GetData.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 24.03.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

private let baseUrl = "https://api.vk.com/method/"
private let apiKey = Session.instance.token

private var parameters: Parameters = [
    "access_token" : apiKey,
    "v" : "5.103"
]

private enum apiMethods: String {
    case friends = "friends.get"
    case groups = "groups.get"
    case photos = "photos.get"
    case groupsSearch = "groups.search"
}

protocol DataServiceProtocol {
    func loadUsers(additionalParameters: [String : Any], completion: @escaping ([User]) -> Void)
    func loadGroups(additionalParameters: [String : Any], completion: @escaping ([Group]) -> Void)
    func loadPhotos(additionalParameters: [String : Any], completion: @escaping ([Photo]) -> Void)
//    func getImageByURL(imageUrl: String) -> UIImage?
}

class DataService: DataServiceProtocol{
    func loadUsers(additionalParameters: [String : Any], completion: @escaping ([User]) -> Void) {
        additionalParameters.forEach { (k,v) in parameters[k] = v }
        
        let url = baseUrl + apiMethods.friends.rawValue
        
        AF.request(url, parameters: parameters).responseJSON { [completion] (response) in
            if let error = response.error {
                print(error)
            } else {
                guard let data = response.data else { return }
                
                let users: [User] = self.parseUsers(data: data)
                
                completion(users)
            }
            
        }
    }
    
    func loadGroups(additionalParameters: [String : Any], completion: @escaping ([Group]) -> Void) {
        //
    }
    
    func loadPhotos(additionalParameters: [String : Any], completion: @escaping ([Photo]) -> Void) {
        //
    }
    
    private func parseUsers(data: Data) -> [User] {
        do {
            let json = try JSON(data: data)
            let array = json["response"]["items"].arrayValue
            
            let result = array.map { item -> User in
                
                var user = User()
                user.id = item["id"].intValue
                user.name = item["first_name"].stringValue + " " + item["last_name"].stringValue
                user.photo = item["photo_200_orig"].stringValue
                
                return user
            }
            
            return result
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
}
