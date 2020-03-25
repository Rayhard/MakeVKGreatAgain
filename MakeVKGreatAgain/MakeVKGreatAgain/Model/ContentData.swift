//
//  ContentData.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 19.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

    // MARK: - Друзья
//let friendsArray: [User] = [User(name: "Nikita",
//                                 photo: UIImage(named: "Nikita"),
//                                 images: [UIImage(named: "Nikita")!,
//                                          UIImage(named: "Petya")!,
//                                          UIImage(named: "Olga")!
//]),
//                            User(name: "Petya",
//                                 photo: UIImage(named: "Petya"),
//                                 images: [UIImage(named: "Petya")!]),
//                            User(name: "Olga",
//                                 photo: UIImage(named: "Olga"),
//                                 images: [UIImage(named: "Olga")!]),
//                            User(name: "Nikolay",
//                                 photo: UIImage(named: "Nikita"),
//                                 images: [UIImage(named: "Nikita")!]),
//                            User(name: "Petr",
//                                 photo: UIImage(named: "Petya"),
//                                 images: [UIImage(named: "Petya")!]),
//                            User(name: "Oleg",
//                                 photo: UIImage(named: "Olga"),
//                                 images: [UIImage(named: "Olga")!]),
//                            User(name: "Vika",
//                                 photo: UIImage(named: "Nikita"),
//                                 images: [UIImage(named: "Nikita")!]),
//                            User(name: "Viktor",
//                                 photo: UIImage(named: "Petya"),
//                                 images: [UIImage(named: "Petya")!]),
//                            User(name: "Viktoriya",
//                                 photo: UIImage(named: "Olga"),
//                                 images: [UIImage(named: "Olga")!]),
//                            User(name: "Proscofia",
//                                 photo: UIImage(named: "Nikita"),
//                                 images: [UIImage(named: "Nikita")!]),
//                            User(name: "Stepan",
//                                 photo: UIImage(named: "Petya"),
//                                 images: [UIImage(named: "Petya")!]),
//                            User(name: "Sofia",
//                                 photo: UIImage(named: "Olga"),
//                                 images: [UIImage(named: "Olga")!]),
//]

    // MARK: - Группы
var userGroupArray = [Group(name: "GeekBrains", photo: UIImage(named: "GeekBrains")),
                      Group(name: "PlayStation", photo: UIImage(named: "PlayStation"))]
var searchGroupArray = [Group(name: "Kanobu", photo: UIImage(named: "Kanobu")),
                        Group(name: "Pikabu", photo: UIImage(named: "Pikabu"))]

    // MARK: - Новости
let newsArray = [News(author: userGroupArray[0], contentText: "Hello world", contentImage: nil),
                 News(author: userGroupArray[0], contentText: "It's-a me, Mario!", contentImage: UIImage(named: "GeekBrains")),
                 News(author: userGroupArray[1], contentText: "Маленькая фотка", contentImage: UIImage(named: "Petya"))
]
