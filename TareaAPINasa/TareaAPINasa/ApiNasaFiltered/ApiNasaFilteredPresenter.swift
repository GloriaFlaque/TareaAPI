//
//  ApiNasaFilteredPresenter.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 04/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

/// Presenter implementation to handle abstract scene view logic.
class ApiNasaFilteredPresenter: Presenter {

    fileprivate weak var view: ApiNasaFilteredView!
    fileprivate weak var wireframe: ApiNasaFilteredWireframe!
    fileprivate var apiInteractor: ApiNasaInteractor!
    var delegate: RefreshTableProtocol?
    var listInfo: [ItemDefault] = []
    var filterList: [ItemDefault] = []

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
    
    func navigateToApiNasaDetail(info: ItemDefault) {
        self.wireframe.navigateToDetail(day: info)
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
    
    func setInfo(info: ItemDefault) {
        self.apiInteractor.setFavorites(item: info) { (result, info)  in
            switch result {
            case .success:
                self.delegate?.refreshFiltered()
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
                self.delegate?.refreshFiltered()
                break
            case .error:
                break
            }
        }
    }
}

extension ApiNasaFilteredPresenter: RefreshTableProtocol {
    func refreshTable(info: [ItemDefault]) {
        self.listInfo = info
        self.performRetriveFavorites()
    }
}

private extension ApiNasaFilteredPresenter {
    
    func performRetriveFavorites() {
        self.view.passInfo(info: listInfo)
        self.delegate?.refreshFiltered()
    }
}
