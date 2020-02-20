//
//  NewsController.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 19.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class NewsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        cell.authorImage.image = newsArray[indexPath.row].author.photo
        cell.authorName.text = newsArray[indexPath.row].author.name
        cell.contentText.text = newsArray[indexPath.row].contentText
        if newsArray[indexPath.row].contentImage == nil {
            cell.contentImageHeight.constant = 1
        } else {
//            cell.contentImageHeight.constant = (newsArray[indexPath.row].contentImage?.size.height)!
            cell.contentImage.image = newsArray[indexPath.row].contentImage
        }

        return cell
    }
}
