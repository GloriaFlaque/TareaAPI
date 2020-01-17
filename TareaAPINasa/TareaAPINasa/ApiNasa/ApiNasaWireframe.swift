//
//  ApiNasaWireframe.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 23/12/2019.
//  Copyright © 2019 Gloria Flaqué García. All rights reserved.
//

import UIKit

/// Wireframe protocol to define routing to other scenes.
protocol ApiNasaWireframe: class {
    func navigateToDetail(item: ItemDefault)
    func navigateToSearch()
    func navigateToFavorites()
}

// MARK: - UIViewController extension to implement wireframe protocol.
extension ApiNasaViewController: ApiNasaWireframe {
    
    func navigateToDetail(item: ItemDefault) {
        self.performSegue(withIdentifier: "ShowDetail", sender: item)
    }
    
    func navigateToSearch() {
            self.performSegue(withIdentifier: "ShowFiltered", sender: self)
    }
    
    func navigateToFavorites() {
        self.performSegue(withIdentifier: "ShowFavorites", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? ApiNasaDetailViewController {
            ApiNasaDetailConfigurator.shared.prepareScene(viewController: detailViewController)
            detailViewController.presenter?.item = sender as? ItemDefault
            detailViewController.presenter?.delegate = self.presenter
            detailViewController.search = "Sun"
        } else if let filterViewController = segue.destination as? ApiNasaFilteredViewController {
            ApiNasaFilteredConfigurator.shared.prepareScene(viewController: filterViewController)
            filterViewController.presenter?.delegate = self.presenter
        } else if let favoritesViewController = segue.destination as? ApiNasaFavoritesViewController {
            ApiNasaFavoritesConfigurator.shared.prepareScene(viewController: favoritesViewController)
            favoritesViewController.presenter?.delegate = self.presenter
        }
    }
}
