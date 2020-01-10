//
//  ApiNasaFilteredDetailPresenter.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

class ApiNasaFilteredDetailPresenter: Presenter {

    fileprivate weak var view: ApiNasaFilteredDetailView!
    fileprivate weak var wireframe: ApiNasaFilteredDetailWireframe!
    var item: [ItemsDatails] = []

    init(view: ApiNasaFilteredDetailView, wireframe: ApiNasaFilteredDetailWireframe) {
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
            self.view.show(item: item)
        case .willDisappear:
            break
        }
    }
}
