//
//  FriendsController.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 09.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class FriendsController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var displayData: [User] = []
    var friendsArray: [User] = []
    
    let getDataService: DataServiceProtocol = DataService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiParameters: [String : Any] = [
            "fields" : "photo_200_orig",
            "order" : "hints",
        ]
        
        getDataService.loadUsers(additionalParameters: apiParameters) { (users) in
            
            do {
                let realm = try Realm()
                let userRealm = realm.objects(User.self)
                self.friendsArray = Array(userRealm)
                self.displayData = self.friendsArray
                
            } catch {
                print(error)
            }
            
            self.tableView.reloadData()
        }
        
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        searchBar.delegate = self as UISearchBarDelegate
        tableView.tableHeaderView = searchBar
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
        
        displayData = friendsArray
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        
        let name = displayData[indexPath.row].name
        cell.userName.text = name
        
        if let url = URL(string: displayData[indexPath.row].photo){
            cell.userImage.kf.indicatorType = .activity
            let resource = ImageResource(downloadURL: url, cacheKey: displayData[indexPath.row].photo)
            cell.userImage.kf.setImage(with: resource)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToFriendImages", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFriendImages"{
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as? FriendsImagesController)?.friend = displayData[indexPath.row]
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}

extension FriendsController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            displayData = friendsArray
            tableView.reloadData()
            return
        }
        displayData = friendsArray.filter { $0.name.range(of: searchText, options: .caseInsensitive) != nil }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
