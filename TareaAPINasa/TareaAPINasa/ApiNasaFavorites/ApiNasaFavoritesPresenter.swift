//
//  ApiNasaFavoritesPresenter.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 13/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

/// Presenter implementation to handle abstract scene view logic.
class ApiNasaFavoritesPresenter: Presenter {

    fileprivate weak var view: ApiNasaFavoritesView!
    fileprivate weak var wireframe: ApiNasaFavoritesWireframe!
    fileprivate var apiInteractor: ApiNasaInteractor!
    var delegate: RefreshTableProtocol?
    var listInfo: [ItemDefault] = []

    init(view: ApiNasaFavoritesView, wireframe: ApiNasaFavoritesWireframe, apiInteractor: ApiNasaInteractor) {
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
    
    func showApiInfo(searchText: String) {
        self.apiInteractor.reatriveApiInformation(searchText: searchText) { (result, info)  in
            switch result {
            case .success:
                self.delegate?.refreshTable(info: info!)
            case .error:
                break
            }
        }
    }
    
    func navigateToApiNasaDetail(item: ItemDefault) {
        self.wireframe.navigateToDetail(item: item)
    }
    
    func getInfo() {
        self.apiInteractor.reatriveFavorites() { (info) in
            self.view.passInfo(info: info!)
        }
    }
    
    func setInfo(info: ItemDefault) {
        self.apiInteractor.setFavorites(item: info) { (result, info)  in
            switch result {
            case .success:
                self.getInfo()
            case .error:
                break
            }
        }
    }
    
    func deletInfo(info: ItemDefault) {
        self.apiInteractor.deleteFavorites(item: info) { (result, info)  in
            switch result {
            case .success:
                self.view.table(info: info!)
            case .error:
                break
            }
        }
    }
}

extension ApiNasaFavoritesPresenter: RefreshTableProtocol {
    func refreshFavorites(info: [ItemDefault]) {
        self.listInfo = info
        self.performRetriveFavorites()
    }
}

private extension ApiNasaFavoritesPresenter {
    
    func performRetriveFavorites() {
        self.view.table(info: listInfo)
        self.delegate?.refreshFiltered()
    }
}
