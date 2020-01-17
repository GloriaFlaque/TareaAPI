//
//  DataNasa.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

struct DataNasa: Codable {
    var date_created: String
    var location: String?
    var description: String
    var description_508: String?
    var title: String
}
