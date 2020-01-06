//
//  ApiNasaDetailPresenter.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 27/12/2019.
//  Copyright © 2019 Gloria Flaqué García. All rights reserved.
//

import Foundation

class ApiNasaDetailPresenter: Presenter {

    fileprivate weak var view: ApiNasaDetailView!
    fileprivate weak var wireframe: ApiNasaDetailWireframe!
    var day: [Info] = []

    init(view: ApiNasaDetailView, wireframe: ApiNasaDetailWireframe) {
        self.view = view
        self.wireframe = wireframe
    }

    func viewDidUpdate(status: ViewStatus) {
        switch status {
        case .didLoad:
            self.view.setupUI()
            self.view.localizeView()
        case .didAppear:
            break
        case .didDisappear:
            break
        case .willAppear:
            self.view.show(day: day)
        case .willDisappear:
            break
        }
    }
}
