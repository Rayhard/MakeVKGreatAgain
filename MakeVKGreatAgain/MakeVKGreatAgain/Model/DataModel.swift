//
//  DataModel.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 09.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit
import RealmSwift

struct Group {
    let name: String
    let photo: UIImage?
}

struct News {
    let author: Group
    let contentText: String
    let contentImage: UIImage?
}

class User: Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var photo: String = ""
}

class Groups: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var photo: String = ""
}

class Photo: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerId: Int = 0
    @objc dynamic var imageUrl: String = ""
}
