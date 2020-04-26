//
//  ContentData.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 19.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

    // MARK: - Группы
var userGroupArray = [Group(name: "GeekBrains", photo: UIImage(named: "GeekBrains")),
                      Group(name: "PlayStation", photo: UIImage(named: "PlayStation"))]

    // MARK: - Новости
let newsArray = [News(author: userGroupArray[0], contentText: "Hello world", contentImage: nil),
                 News(author: userGroupArray[0], contentText: "It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!It's-a me, Mario!", contentImage: UIImage(named: "GeekBrains")),
                 News(author: userGroupArray[1], contentText: "Маленькая фотка", contentImage: UIImage(named: "Petya"))
]
