//
//  ApiNasaDetailConfigurator.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import UIKit

class ApiNasaDetailConfigurator: Configurator {
    
    static let shared = ApiNasaDetailConfigurator()
    
    /// Class constants.
    fileprivate struct Constants {
        static let storyboardName: String = "Main"
        static let storyboardId: String = "ApiNasaFilteredDetailViewController"
    }
    
    func isValid(viewController: UIViewController) -> Bool {
        return viewController is ApiNasaDetailViewController
    }
    
    func storyboardName() -> String {
        return Constants.storyboardName
    }
    
    func storyboardId() -> String {
        return Constants.storyboardId
    }
    
    func prepareScene(viewController: UIViewController) {
        let presenter = ApiNasaDetailPresenter(view: viewController as! ApiNasaDetailView,
                                         wireframe: viewController as! ApiNasaDetailWireframe, apiInteractor: ApiNasaInteractorImpl(repository: ApiNasaDataRepository()))
        guard let apiNasaFilteredDetailViewController = viewController as? ApiNasaDetailViewController else {
            assertionFailure("Invalid UIViewController to prepare scene")
            return
        }
        apiNasaFilteredDetailViewController.presenter = presenter
    }
}

