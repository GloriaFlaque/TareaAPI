//
//  ItemDefault.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 14/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

class ItemDefault: Codable {
    var data: [DataNasa] = []
    var links: [Link] = []
    var favorite = false
    
    init(data: [DataNasa], links: [Link], favorite: Bool) {
        self.data = data
        self.links = links
        self.favorite = favorite
    }
//    NSObject,NSCoding
//    init(data: [DataNasa], links: [Link]) {
//    self.data = data
//    self.links = links
//    }
//
//    func encode(with coder: NSCoder) {
//        coder.encode(data, forKey: "data")
//        coder.encode(links, forKey: "links")
//    }
//
//    required convenience init?(coder aDecoder: NSCoder) {
//        let data = aDecoder.decodeObject(forKey: "data") as! [DataNasa]
//        let links = aDecoder.decodeObject(forKey: "links") as! [Link]
//        self.init(data: data, links: links)
//    }

}
    
 
