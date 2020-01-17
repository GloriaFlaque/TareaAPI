//
//  ApiNasaPresenter.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 23/12/2019.
//  Copyright © 2019 Gloria Flaqué García. All rights reserved.
//

import Foundation

/// Presenter implementation to handle abstract scene view logic.
class ApiNasaPresenter: Presenter {

    fileprivate weak var view: ApiNasaView!
    fileprivate weak var wireframe: ApiNasaWireframe!
    fileprivate var apiInteractor: ApiNasaInteractor!
    var listInfo: [ItemDefault] = []

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
            self.performRetriveFavorites()
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
    
    func navigateToApiNasaDetail(item: ItemDefault) {
        self.wireframe.navigateToDetail(item: item)
    }
    
    func navigateToApiNasaSearch() {
        self.wireframe.navigateToSearch()
    }
    
    func navigateToApiNasaFavorites() {
        self.wireframe.navigateToFavorites()
    }
    
    func showApiInfo(searchText: String) {
        self.apiInteractor.reatriveApiInformation(searchText: searchText) { (result, info)  in
            switch result {
            case .success:
                self.view.passInfo(info: info!)
            case .error:
                break
            }
        }
    }
    
    func setInfo(info: ItemDefault) {
        self.apiInteractor.setFavorites(item: info) { (result, info)  in
            switch result {
            case .success:
                break
            case .error:
                break
            }
        }
    }
    
    func deletInfo(info: ItemDefault) {
        self.apiInteractor.deleteFavorites(item: info) { (result, info)  in
            switch result {
            case .success:
                break
            case .error:
                break
            }
        }
    }
}

extension ApiNasaPresenter: RefreshTableProtocol {
    func refreshTable(info: [ItemDefault]) {
        self.listInfo = info
        self.performRetriveFavorites()
    }
    
    func refreshFiltered() {
        self.performeRetiveFiltered()
    }
}

private extension ApiNasaPresenter {
    
    func performRetriveFavorites() {
        self.view.passInfo(info: listInfo)
    }
    
    func performeRetiveFiltered() {
        self.showApiInfo(searchText: "Sun")
    }
}


