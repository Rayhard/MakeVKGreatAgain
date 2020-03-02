//
//  FriendsController.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 09.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class FriendsController: UITableViewController {
    
    var friendsArray: [User] = [User(name: "Nikita",
                                     photo: UIImage(named: "Nikita"),
                                     images: [UIImage(named: "Nikita")!]),
                                User(name: "Petya",
                                     photo: UIImage(named: "Petya"),
                                     images: [UIImage(named: "Petya")!]),
                                User(name: "Olga",
                                     photo: UIImage(named: "Olga"),
                                     images: [UIImage(named: "Olga")!])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FriendCell
        
        cell.friendName.text = friendsArray[indexPath.row].name
        cell.friendImage.image = friendsArray[indexPath.row].photo

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFriendImages"{
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as? FriendsImagesController)?.friendImagesArray = friendsArray[indexPath.row].images
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
