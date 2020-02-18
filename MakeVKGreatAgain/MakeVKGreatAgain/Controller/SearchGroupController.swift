//
//  SearchGroupController.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 09.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class SearchGroupController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchGroupArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellSearch", for: indexPath) as! SearchGroupCell
        cell.searchGroupName.text = searchGroupArray[indexPath.row].name
        cell.searchGroupImage.image = searchGroupArray[indexPath.row].photo

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        userGroupArray.append(searchGroupArray[indexPath.row])
        searchGroupArray.remove(at: indexPath.row)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

}
