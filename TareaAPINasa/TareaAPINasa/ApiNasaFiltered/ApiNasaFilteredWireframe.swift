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
    func navigateToDetail(day: [ItemsDatails])
    func passInfo(info: [ItemsDatails])
}

// MARK: - UIViewController extension to implement wireframe protocol.
extension ApiNasaFilteredViewController: ApiNasaFilteredWireframe {
    
    func navigateToDetail(day: [ItemsDatails]) {
        self.performSegue(withIdentifier: "ShowDetailFiltered", sender: day)
    }
    
    func passInfo(info: [ItemsDatails]) {
//        self.collectionlist = []
        self.collectionlist = info
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? ApiNasaFilteredDetailViewController {
            ApiNasaFilteredDetailConfigurator.shared.prepareScene(viewController: detailViewController)
            detailViewController.presenter?.item = sender as! [ItemsDatails]
        }
    }
}
