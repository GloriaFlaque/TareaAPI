//
//  ItemDetails.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

struct ItemDetails: Codable {
    var data: [DataNasa]
    var links: [Link]
//    var favorite = false
}
