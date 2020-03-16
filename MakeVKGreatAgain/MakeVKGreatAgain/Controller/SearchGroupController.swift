//
//  SearchGroupController.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 09.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class SearchGroupController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    var displayData: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "GroupCell", bundle: nil), forCellReuseIdentifier: "GroupCell")
        searchBar.delegate = self as UISearchBarDelegate
        tableView.tableHeaderView = searchBar
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
        displayData = searchGroupArray
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
        cell.groupImage.image = displayData[indexPath.row].photo

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        userGroupArray.append(displayData[indexPath.row])
        displayData.remove(at: indexPath.row)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

}

extension SearchGroupController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            displayData = searchGroupArray
            tableView.reloadData()
            return
        }
        displayData = searchGroupArray.filter { $0.name.range(of: searchText, options: .caseInsensitive) != nil }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
