//
//  ApiNasaDetailView.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

protocol ApiNasaDetailView: ViewProtocol {
    func show(item: [ItemDetails])
}
