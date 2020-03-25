//
//  DataModel.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 09.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

struct Useraaaa {
    let name: String
    let photo: UIImage?
    let images: [UIImage]
    
}

struct Group {
    let name: String
    let photo: UIImage?
}

struct News {
    let author: Group
    let contentText: String
    let contentImage: UIImage?
}

struct User {
    var id: Int = 0
    var name: String = ""
    var photo: String = ""
}

struct Groups {
    var id: Int = 0
    var name: String = ""
    var photo: String = ""
}

class Photo {
    var id: Int = 0
    var ownerId: Int = 0
    var imageUrl: String = ""
}
