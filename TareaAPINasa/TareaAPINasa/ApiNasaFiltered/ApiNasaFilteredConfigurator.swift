//
//  ApiNasaFilteredConfigurator.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 04/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import UIKit

class ApiNasaFilteredConfigurator: Configurator {
    
    static let shared = ApiNasaFilteredConfigurator()
    
    /// Class constants.
    fileprivate struct Constants {
        static let storyboardName: String = "Main"
        static let storyboardId: String = "ApiNasaFilteredViewController"
    }
    
    func isValid(viewController: UIViewController) -> Bool {
        return viewController is ApiNasaFilteredViewController
    }
    
    func storyboardName() -> String {
        return Constants.storyboardName
    }
    
    func storyboardId() -> String {
        return Constants.storyboardId
    }
    
    func prepareScene(viewController: UIViewController) {
        let presenter = ApiNasaFilteredPresenter(view: viewController as! ApiNasaFilteredView, wireframe: viewController as! ApiNasaFilteredWireframe)
        guard let apiNasaFilteredViewController = viewController as? ApiNasaFilteredViewController else {
            assertionFailure("Invalid UIViewController to prepare scene")
            return
        }
        apiNasaFilteredViewController.presenter = presenter
    }
}

