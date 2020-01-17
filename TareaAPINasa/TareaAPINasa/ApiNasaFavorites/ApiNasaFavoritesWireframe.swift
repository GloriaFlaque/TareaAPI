//
//  ApiNasaFavoritesWireframe.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 13/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import UIKit

/// Wireframe protocol to define routing to other scenes.
protocol ApiNasaFavoritesWireframe: class {
    func navigateToDetail(item: ItemDefault)
}

// MARK: - UIViewController extension to implement wireframe protocol.
extension ApiNasaFavoritesViewController: ApiNasaFavoritesWireframe {
    
    func navigateToDetail(item: ItemDefault) {
        self.performSegue(withIdentifier: "ShowDetailFavorites", sender: item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? ApiNasaDetailViewController {
            ApiNasaDetailConfigurator.shared.prepareScene(viewController: detailViewController)
            detailViewController.presenter?.item = sender as? ItemDefault
            detailViewController.presenter?.delegate = self.presenter
        }
    }
}

