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
import RealmSwift

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
    func loadGroups(additionalParameters: [String : Any], completion: @escaping ([Groups]) -> Void)
    func loadSearchGroups(additionalParameters: [String : Any], completion: @escaping ([Groups]) -> Void)
    func loadPhotos(additionalParameters: [String : Any], completion: @escaping ([Photo]) -> Void)
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
                
                self.saveData(data: users)
                
                completion(users)
            }
            
        }
    }
    
    func loadGroups(additionalParameters: [String : Any], completion: @escaping ([Groups]) -> Void) {

        additionalParameters.forEach { (k,v) in parameters[k] = v }
        
        let url = baseUrl + apiMethods.groups.rawValue
        
        AF.request(url, parameters: parameters).responseJSON { [completion] (response) in
            if let error = response.error {
                print(error)
            } else {
                guard let data = response.data else { return }
                
                let groups: [Groups] = self.parseGroups(data: data)
                
                self.saveData(data: groups)
                
                completion(groups)
            }
            
        }
    }
    
    func loadSearchGroups(additionalParameters: [String : Any], completion: @escaping ([Groups]) -> Void) {
        
        additionalParameters.forEach { (k,v) in parameters[k] = v }
        
        let url = baseUrl + apiMethods.groupsSearch.rawValue
        
        AF.request(url, parameters: parameters).responseJSON { [completion] (response) in
            if let error = response.error {
                print(error)
            } else {
                guard let data = response.data else { return }
                
                let groups: [Groups] = self.parseGroups(data: data)
                
                completion(groups)
            }
            
        }
    }
    
    func loadPhotos(additionalParameters: [String : Any], completion: @escaping ([Photo]) -> Void) {
        
        additionalParameters.forEach { (k,v) in parameters[k] = v }
        
        let url = baseUrl + apiMethods.photos.rawValue
        
        AF.request(url, parameters: parameters).responseJSON { [completion] (response) in
            if let error = response.error {
                print(error)
            } else {
                guard let data = response.data else { return }
                
                let photos: [Photo] = self.parsePhotos(data: data)
                
                self.saveData(data: photos)
                
                completion(photos)
            }
            
        }
    }
    
    private func parseUsers(data: Data) -> [User] {
        do {
            let json = try JSON(data: data)
            let array = json["response"]["items"].arrayValue
            
            let result = array.map { item -> User in
                
                let user = User()
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
    
    private func parseGroups(data: Data) -> [Groups] {
        do {
            let json = try JSON(data: data)
            let array = json["response"]["items"].arrayValue
            
            let result = array.map { item -> Groups in
            
                let group = Groups()
                
                group.id = item["id"].intValue
                group.name = item["name"].stringValue
                group.photo = item["photo_200"].stringValue
                
                return group
            }
            
            return result
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    private func parsePhotos(data: Data) -> [Photo] {
        do {
            let json = try JSON(data: data)
            let array = json["response"]["items"].arrayValue
            
            let result = array.map { item -> Photo in
                
                let photo = Photo()
                photo.id = item["id"].intValue
                photo.ownerId = item["owner_id"].intValue
                
                let sizeValues = item["sizes"].arrayValue
                if let first = sizeValues.first(where: { $0["type"].stringValue == "z" }) {
                    photo.imageUrl = first["url"].stringValue
                }
                
                return photo
            }
            
            return result
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    private func saveData(data: [Object]){
        do {
            let realm = try Realm()
            print(realm.configuration.fileURL)
            let oldData = realm.objects(type(of: data[0]))
            
            realm.beginWrite()
            realm.delete(oldData)
            realm.add(data)
            try realm.commitWrite()
            
        } catch {
            print(error)
        }

    }
}
