//
//  ApiNasaFavoritesView.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 13/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

/// View protocol interface to enable comunication with view logic implementation (Presenter)
protocol ApiNasaFavoritesView: ViewProtocol {
    
    func passInfo(info: [ItemDefault])
    
    func table(info: [ItemDefault])
}
