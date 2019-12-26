//
//  ApiNasaPresenter.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 23/12/2019.
//  Copyright © 2019 Gloria Flaqué García. All rights reserved.
//

import Foundation

/// Protocol delegate.
class ApiNasaPresenterDelegate {

}

class ApiNasaPresenter: Presenter {

fileprivate weak var view: ApiNasaView!
fileprivate weak var wireframe: ApiNasaWireframe!

init(view: ApiNasaView, wireframe: ApiNasaWireframe) {
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
    
}
