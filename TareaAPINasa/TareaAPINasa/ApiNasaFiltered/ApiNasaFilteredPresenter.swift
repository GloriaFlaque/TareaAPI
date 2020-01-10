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
fileprivate var apiInteractor: ApiNasaImageInteractor!
fileprivate var list: [ItemsDatails] = []

    init(view: ApiNasaFilteredView, wireframe: ApiNasaFilteredWireframe, nasaImageRequestResult: ApiNasaImageInteractor) {
    self.view = view
    self.wireframe = wireframe
    self.apiInteractor = nasaImageRequestResult
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
    
    func showApiImageInfo(conceptCode: String) {
        self.apiInteractor.reatriveApiInformation(conceptCode: conceptCode) { (result, info)  in
            switch result {
            case .success:
                guard let infoNasa = info else { return }
                for x in infoNasa {
                    for i in x.links {
                        if !i.href.contains("video") {
                            self.list.append(x)
                            self.wireframe.passInfo(info: self.list)
                        }
                    }
                }
            case .error:
                break
            }
        }
    }
}
