//
//  RefreshTableProtocol.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 15/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import UIKit

protocol RefreshTableProtocol {
    
    func refreshTable(info: [ItemDefault])
    
    func refreshFavorites(info: [ItemDefault])
    
    func refreshFiltered()
}

extension RefreshTableProtocol {
    
    func refreshTable(info: [ItemDefault]) {}
    
    func refreshFavorites(info: [ItemDefault]) {}
    
    func refreshFiltered() {}
}
