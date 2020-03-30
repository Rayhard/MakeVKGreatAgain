//
//  UserGroupController.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 09.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class UserGroupController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    var displayData: [Groups] = []
    var userGroup: [Groups] = []
    
    let getDataService: DataServiceProtocol = DataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "GroupCell", bundle: nil), forCellReuseIdentifier: "GroupCell")
        searchBar.delegate = self as UISearchBarDelegate
        tableView.tableHeaderView = searchBar
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
        
        getDataService.loadGroups(additionalParameters: ["extended": 1]) { (groups) in
            
            do {
                let realm = try Realm()
                let groupRealm = realm.objects(Groups.self)
                self.displayData = Array(groupRealm)
                self.userGroup = self.displayData
                
            } catch {
                print(error)
            }
            
            self.tableView.reloadData()
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        cell.groupName.text = displayData[indexPath.row].name
        
        if let url = URL(string: displayData[indexPath.row].photo){
            cell.groupImage.kf.indicatorType = .activity
            let resource = ImageResource(downloadURL: url, cacheKey: displayData[indexPath.row].photo)
            cell.groupImage.kf.setImage(with: resource)
        }
        
        return cell
    }

}

extension UserGroupController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            displayData = userGroup
            tableView.reloadData()
            return
        }
        displayData = userGroup.filter { $0.name.range(of: searchText, options: .caseInsensitive) != nil }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        self.searchBar.endEditing(true)
    }
}
