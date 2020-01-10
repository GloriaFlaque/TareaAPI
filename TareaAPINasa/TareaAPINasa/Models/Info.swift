//
//  Info.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

struct Info: Decodable {
    var date: String
    var explanation: String
    var hdurl: String
    var media_type: String
    var title: String
}
