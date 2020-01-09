//
//  ApiNasaFilteredPresenter.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 04/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

class ApiNasaFilteredPresenter: Presenter {

fileprivate weak var view: ApiNasaFilteredView!
fileprivate weak var wireframe: ApiNasaFilteredWireframe!

init(view: ApiNasaFilteredView, wireframe: ApiNasaFilteredWireframe) {
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
            break
        case .willDisappear:
            break
        }
    }
    
    func navigateToApiNasaDetail(day: [ItemsDatails]) {
        self.wireframe.navigateToDetail(day: day)
    }
}
