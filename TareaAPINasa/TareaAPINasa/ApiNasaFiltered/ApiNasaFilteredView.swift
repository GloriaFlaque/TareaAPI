//
//  ApiNasaFilteredView.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 04/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

protocol ApiNasaFilteredView: ViewProtocol {
    func passInfo(info: [ItemDetails])
}
