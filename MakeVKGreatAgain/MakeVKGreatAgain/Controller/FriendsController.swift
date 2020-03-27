//
//  FriendsController.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 09.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class FriendsController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var displayData: [User] = []
    var friendsArray: [User] = []
    
    let getDataService: DataServiceProtocol = DataService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiParameters: [String : Any] = [
            "fields" : "photo_200_orig",
            "order" : "name",
        ]
        
        getDataService.loadUsers(additionalParameters: apiParameters) { (users) in
            self.friendsArray = users
            self.displayData = self.friendsArray
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
        //let image = displayData[indexPath.row].photo
        cell.userName.text = name
        //cell.userImage.image = image

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
