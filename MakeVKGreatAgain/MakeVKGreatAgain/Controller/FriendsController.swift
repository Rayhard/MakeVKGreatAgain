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
    
    
    var users: Results<User>?
    var token: NotificationToken?
    
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
                self.users = realm.objects(User.self)
                self.token = self.users?.observe { [weak self] (changes: RealmCollectionChange) in
                    switch changes {
                    case .initial:
                        self?.tableView.reloadData()
                        
                    case .update(_, let deletions, let insertions, let modifications):
                        self?.tableView.beginUpdates()
                        self?.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                                   with: .automatic)
                        self?.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                                   with: .automatic)
                        self?.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                                   with: .automatic)
                        self?.tableView.endUpdates()
                        
                    case .error(let error):
                        print(error.localizedDescription)
                        
                    }
                }
                self.tableView.reloadData()
                
            } catch {
                print(error.localizedDescription)
            }
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
        return users?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        
        let user = users?[indexPath.row]
        
        cell.userName.text = user?.name
        
        if let url = URL(string: user?.photo ?? ""){
            cell.userImage.kf.indicatorType = .activity
            let resource = ImageResource(downloadURL: url, cacheKey: user?.photo ?? "")
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
                (segue.destination as? FriendsImagesController)?.friend = users?[indexPath.row]
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
