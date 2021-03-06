//
//  ApiNasaView.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 23/12/2019.
//  Copyright © 2019 Gloria Flaqué García. All rights reserved.
//

import Foundation

/// View protocol interface to enable comunication with view logic implementation (Presenter)
protocol ApiNasaView: ViewProtocol {
    func passInfo(info: [ItemDefault])
    
    func table(info: [ItemDefault])
}
