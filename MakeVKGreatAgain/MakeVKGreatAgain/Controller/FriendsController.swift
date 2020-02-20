//
//  FriendsController.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 09.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class FriendsController: UITableViewController {
    
    var names: [User]{
        return friendsArray.sorted(by: {$0.name < $1.name})
    }
    lazy var sections: [[User]] = {
        return names.reduce([[User]]()){ (result, element) -> [[User]] in
            guard var last = result.last else {return [[element]]}
            var collection = result
            if element.name.first == result.last?.first?.name.first{
                last.append(element)
                collection[collection.count-1] = last
            } else {
                collection.append([element])
            }
            return collection
            
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].first?.name.first?.uppercased()
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return Array(Set(names.compactMap{$0.name.first?.uppercased()})).sorted()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FriendCell
        let name = sections[indexPath.section][indexPath.row].name
        let image = sections[indexPath.section][indexPath.row].photo
        cell.friendName.text = name
        cell.friendImage.image = image

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFriendImages"{
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as? FriendsImagesController)?.friendImagesArray = sections[indexPath.section][indexPath.row].images
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}
