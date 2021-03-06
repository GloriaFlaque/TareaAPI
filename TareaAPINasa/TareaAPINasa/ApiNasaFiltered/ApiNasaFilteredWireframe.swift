//
//  ApiNasaFilteredWireframe.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 04/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import UIKit

/// Wireframe protocol to define routing to other scenes.
protocol ApiNasaFilteredWireframe: class {
    func navigateToDetail(day: ItemDefault)
}

// MARK: - UIViewController extension to implement wireframe protocol.
extension ApiNasaFilteredViewController: ApiNasaFilteredWireframe {
    
    func navigateToDetail(day: ItemDefault) {
        self.performSegue(withIdentifier: "ShowDetailFiltered", sender: day)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? ApiNasaDetailViewController {
            ApiNasaDetailConfigurator.shared.prepareScene(viewController: detailViewController)
            detailViewController.presenter?.item = sender as? ItemDefault
            detailViewController.presenter?.delegate = self.presenter
            detailViewController.search = self.search
        }
    }
}
