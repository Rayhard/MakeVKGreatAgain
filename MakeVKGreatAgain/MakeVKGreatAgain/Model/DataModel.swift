//
//  DataModel.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 09.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

struct User {
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
