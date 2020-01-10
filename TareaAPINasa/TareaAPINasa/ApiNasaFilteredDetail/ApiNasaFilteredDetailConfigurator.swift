//
//  ApiNasaFilteredDetailConfigurator.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import UIKit

class ApiNasaFilteredDetailConfigurator: Configurator {
    
    static let shared = ApiNasaFilteredDetailConfigurator()
    
    /// Class constants.
    fileprivate struct Constants {
        static let storyboardName: String = "Main"
        static let storyboardId: String = "ApiNasaFilteredDetailViewController"
    }
    
    func isValid(viewController: UIViewController) -> Bool {
        return viewController is ApiNasaFilteredDetailViewController
    }
    
    func storyboardName() -> String {
        return Constants.storyboardName
    }
    
    func storyboardId() -> String {
        return Constants.storyboardId
    }
    
    func prepareScene(viewController: UIViewController) {
        let presenter = ApiNasaFilteredDetailPresenter(view: viewController as! ApiNasaFilteredDetailView,
                                         wireframe: viewController as! ApiNasaFilteredDetailWireframe)
        guard let apiNasaFilteredDetailViewController = viewController as? ApiNasaFilteredDetailViewController else {
            assertionFailure("Invalid UIViewController to prepare scene")
            return
        }
        apiNasaFilteredDetailViewController.presenter = presenter
    }
}

