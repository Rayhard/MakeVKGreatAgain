//
//  UserGroupController.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 09.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class UserGroupController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    var displayData: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self as UISearchBarDelegate
        tableView.tableHeaderView = searchBar
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
        
        displayData = userGroupArray
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
    }
    
     @objc func refresh() {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserGroupCell
        cell.userGroupName.text = displayData[indexPath.row].name
        cell.userGroupImage.image = displayData[indexPath.row].photo
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            searchGroupArray.append(displayData[indexPath.row])
            displayData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

extension UserGroupController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            displayData = userGroupArray
            tableView.reloadData()
            return
        }
        displayData = userGroupArray.filter { $0.name.range(of: searchText, options: .caseInsensitive) != nil }
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
