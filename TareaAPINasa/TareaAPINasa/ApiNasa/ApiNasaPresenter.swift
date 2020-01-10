//
//  ApiNasaPresenter.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 23/12/2019.
//  Copyright © 2019 Gloria Flaqué García. All rights reserved.
//

import Foundation

class ApiNasaPresenter: Presenter {

fileprivate weak var view: ApiNasaView!
fileprivate weak var wireframe: ApiNasaWireframe!
fileprivate var apiInteractor: ApiNasaDayInteractor!

    init(view: ApiNasaView, wireframe: ApiNasaWireframe, apiInteractor: ApiNasaDayInteractor) {
    self.view = view
    self.wireframe = wireframe
    self.apiInteractor = apiInteractor
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
    
    func navigateToApiNasaDetail(day: [Info]) {
        self.wireframe.navigateToDetail(day: day)
    }
    
    func navigateToApiNasaSearch() {
        self.wireframe.navigateToSearch()
    }
    
    func showApiDayInfo(conceptCode: String) {
        self.apiInteractor.reatriveApiInformation(conceptCode: conceptCode) { (result, info)  in
            switch result {
            case .success:
                guard let infoNasa = info else { return }
                self.wireframe.passInfo(info: infoNasa)
            case .error:
                break
            }
        }
    }
}
