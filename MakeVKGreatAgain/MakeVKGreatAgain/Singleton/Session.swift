//
//  Session.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 11.03.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import Foundation

class Session {
    static let instance = Session()
    
    var token: String = ""
    var userId: Int = 0
    
    private init(){}
}
