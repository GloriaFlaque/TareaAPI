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
    func navigateToDetail(day: [Info])
}

// MARK: - UIViewController extension to implement wireframe protocol.
extension ApiNasaFilteredViewController: ApiNasaFilteredWireframe {
    
    func navigateToDetail(day: [Info]) {
        self.performSegue(withIdentifier: "ShowDetailFiltered", sender: day)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? ApiNasaDetailViewController {
            ApiNasaDetailConfigurator.shared.prepareScene(viewController: detailViewController)
            detailViewController.presenter?.day = sender as! [Info]
        }
    }
}
