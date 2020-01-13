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
fileprivate var apiInteractor: ApiNasaInteractor!

    init(view: ApiNasaFilteredView, wireframe: ApiNasaFilteredWireframe, nasaImageRequestResult: ApiNasaInteractor) {
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
    
    func navigateToApiNasaDetail(day: [ItemDetails]) {
        self.wireframe.navigateToDetail(day: day)
    }
    
    func showApiImageInfo(searchText: String) {
        self.apiInteractor.reatriveApiInformation(searchText: searchText) { (result, info)  in
            switch result {
            case .success:
                self.view.passInfo(info: info!)
            case .error:
                break
            }
        }
    }
}
