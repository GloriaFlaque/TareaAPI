//
//  ApiNasaDetailView.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

/// View protocol interface to enable comunication with view logic implementation (Presenter)
protocol ApiNasaDetailView: ViewProtocol {
    func show(item: ItemDefault)
}
