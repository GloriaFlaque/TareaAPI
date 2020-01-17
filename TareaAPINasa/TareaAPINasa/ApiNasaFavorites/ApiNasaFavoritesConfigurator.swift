//
//  ApiNasaFavoritesConfigurator.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 13/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import UIKit

class ApiNasaFavoritesConfigurator: Configurator {
    
    static let shared = ApiNasaFavoritesConfigurator()
    
    /// Class constants.
    fileprivate struct Constants {
        static let storyboardName: String = "Main"
        static let storyboardId: String = "ApiNasaFavoritesViewController"
    }
    
    func isValid(viewController: UIViewController) -> Bool {
        return viewController is ApiNasaViewController
    }
    
    func storyboardName() -> String {
        return Constants.storyboardName
    }
    
    func storyboardId() -> String {
        return Constants.storyboardId
    }
    
    func prepareScene(viewController: UIViewController) {
        let presenter = ApiNasaFavoritesPresenter(view: viewController as! ApiNasaFavoritesView,
                                         wireframe: viewController as! ApiNasaFavoritesWireframe, apiInteractor: ApiNasaInteractorImpl(repository: ApiNasaDataRepository()))
        guard let apiNasaViewController = viewController as? ApiNasaFavoritesViewController else {
            assertionFailure("Invalid UIViewController to prepare scene")
            return
        }
        apiNasaViewController.presenter = presenter
    }
}
