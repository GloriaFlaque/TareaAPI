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
fileprivate var apiInteractor: ApiNasaInteractor!

    init(view: ApiNasaView, wireframe: ApiNasaWireframe, apiInteractor: ApiNasaInteractor) {
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
    
    func navigateToApiNasaDetail(item: [ItemDetails]) {
        self.wireframe.navigateToDetail(item: item)
    }
    
    func navigateToApiNasaSearch() {
        self.wireframe.navigateToSearch()
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
