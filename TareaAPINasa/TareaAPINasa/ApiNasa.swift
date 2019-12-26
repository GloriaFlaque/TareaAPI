//
//  ApiNasa.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 26/12/2019.
//  Copyright © 2019 Gloria Flaqué García. All rights reserved.
//

import Foundation

struct Info:Decodable {
    var copyright: String
    var date: String
    var explanation: String
    var hdurl: String
    var media_type: String
    var service_version: String
    var title: String
    var url: String
    
}


