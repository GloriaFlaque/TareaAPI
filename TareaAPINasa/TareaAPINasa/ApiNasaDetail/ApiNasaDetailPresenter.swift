//
//  ApiNasaDetailPresenter.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

/// Presenter implementation to handle abstract scene view logic.
class ApiNasaDetailPresenter: Presenter {

    fileprivate weak var view: ApiNasaDetailView!
    fileprivate weak var wireframe: ApiNasaDetailWireframe!
    fileprivate var apiInteractor: ApiNasaInteractor!
    var item: ItemDefault!
    var delegate: RefreshTableProtocol?

    init(view: ApiNasaDetailView, wireframe: ApiNasaDetailWireframe, apiInteractor: ApiNasaInteractor) {
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
            self.view.show(item: item)
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
    
    func setInfo(info: ItemDefault) {
        self.apiInteractor.setFavorites(item: info) { (result, info)  in
            switch result {
            case .success:
                self.delegate?.refreshFavorites(info: info!)
            case .error:
                break
            }
        }
    }
    
    func deletInfo(info: ItemDefault) {
        self.apiInteractor.deleteFavorites(item: info) { (result, info)  in
            switch result {
            case .success:
                self.delegate?.refreshFavorites(info: info!)
            case .error:
                break
            }
        }
    }
}
