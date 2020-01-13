//
//  ApiNasaConfigurator.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 23/12/2019.
//  Copyright © 2019 Gloria Flaqué García. All rights reserved.
//

import UIKit

class ApiNasaConfigurator: Configurator {
    
    static let shared = ApiNasaConfigurator()
    
    /// Class constants.
    fileprivate struct Constants {
        static let storyboardName: String = "Main"
        static let storyboardId: String = "ApiNasaViewController"
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
        let presenter = ApiNasaPresenter(view: viewController as! ApiNasaView,
                                         wireframe: viewController as! ApiNasaWireframe, apiInteractor: ApiNasaInteractorImpl(repository: ApiNasaDataRepository()))
        guard let apiNasaViewController = viewController as? ApiNasaViewController else {
            assertionFailure("Invalid UIViewController to prepare scene")
            return
        }
        apiNasaViewController.presenter = presenter
    }
}
