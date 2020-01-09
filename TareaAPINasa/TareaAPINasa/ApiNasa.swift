//
//  ApiNasa.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 26/12/2019.
//  Copyright © 2019 Gloria Flaqué García. All rights reserved.
//

import Foundation

struct Info: Decodable {
    var date: String
    var explanation: String
    var hdurl: String
    var media_type: String
    var title: String
}

struct Data: Decodable {
    var date_created: String
    var description: String
    var title: String
}

struct Link: Decodable {
    var href: String
}

struct ItemsDatails: Decodable {
    var data: [Data]
    var link: [Link]
}

struct ItemsInfo: Decodable {
    var items: [ItemsDatails]
}

struct CollectionInfo: Decodable {
    var collection: ItemsInfo
}
