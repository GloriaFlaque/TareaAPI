//
//  ItemDetails.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

struct ItemDetails: Decodable {
    var data: [Data]
    var links: [Link]
}
