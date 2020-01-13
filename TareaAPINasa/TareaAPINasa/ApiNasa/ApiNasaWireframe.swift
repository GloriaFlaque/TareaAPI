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
    func navigateToDetail(item: [ItemDetails])
    func navigateToSearch()
}

// MARK: - UIViewController extension to implement wireframe protocol.
extension ApiNasaViewController: ApiNasaWireframe {
    
    func navigateToDetail(item: [ItemDetails]) {
        self.performSegue(withIdentifier: "ShowDetail", sender: item)
    }
    
    func navigateToSearch() {
            self.performSegue(withIdentifier: "ShowFiltered", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? ApiNasaDetailViewController {
            ApiNasaDetailConfigurator.shared.prepareScene(viewController: detailViewController)
            detailViewController.presenter?.item = sender as! [ItemDetails]
        } else if let filterViewController = segue.destination as? ApiNasaFilteredViewController {
            ApiNasaFilteredConfigurator.shared.prepareScene(viewController: filterViewController)
        }
    }
}
