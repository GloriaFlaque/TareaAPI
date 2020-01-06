//
//  ApiNasaDetailView.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 27/12/2019.
//  Copyright © 2019 Gloria Flaqué García. All rights reserved.
//

import Foundation

protocol ApiNasaDetailView: ViewProtocol, FeedbackViewProtocol {
    func show(day: [Info])
}
