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

var userGroupArray = [Group(name: "GeekBrains", photo: UIImage(named: "GeekBrains")),
                      Group(name: "PlayStation", photo: UIImage(named: "PlayStation"))]
var searchGroupArray = [Group(name: "Kanobu", photo: UIImage(named: "Kanobu")),
                        Group(name: "Pikabu", photo: UIImage(named: "Pikabu"))]
