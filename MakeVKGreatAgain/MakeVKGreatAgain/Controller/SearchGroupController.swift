//
//  SearchGroupController.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 09.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit
import Kingfisher

class SearchGroupController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    let getDataService: DataServiceProtocol = DataService()
    var displayData: [Groups] = []
    var searchGroup: [Groups] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "GroupCell", bundle: nil), forCellReuseIdentifier: "GroupCell")
        searchBar.delegate = self as UISearchBarDelegate
        tableView.tableHeaderView = searchBar
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        displayData.remove(at: indexPath.row)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

}

extension SearchGroupController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            displayData = searchGroup
            tableView.reloadData()
            return
        }
        
        getDataService.loadSearchGroups(additionalParameters: ["q": searchText]) { (groups) in
            self.displayData = groups
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
