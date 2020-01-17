//
//  ApiNasaFavoritesViewController.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 13/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import UIKit

class ApiNasaFavoritesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var presenter: ApiNasaFavoritesPresenter?
    var favoritesList: [ItemDefault] = []
    var customTableView: CustomTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidUpdate(status: .didLoad)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter?.viewDidUpdate(status: .didAppear)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewDidUpdate(status: .willAppear)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.presenter?.viewDidUpdate(status: .didDisappear)
    }
}

extension ApiNasaFavoritesViewController: ApiNasaFavoritesView {
    func passInfo(info: [ItemDefault]) {
        self.favoritesList = info
    }
    
    func setupUI() {
        self.presenter?.getInfo()
        tableView.register(UINib(nibName: "NasaCell", bundle: nil), forCellReuseIdentifier: "nasaCell")
        self.customTableView = CustomTableViewController(items: favoritesList)
        self.customTableView?.delegate = self
        self.tableView.dataSource = self.customTableView!
        self.tableView.delegate = self.customTableView!
    }
    
    func table(info: [ItemDefault]) {
        self.favoritesList = info
        DispatchQueue.main.async {
            self.customTableView!.items = info
            self.tableView.reloadData()
        }
    }
}

private extension ApiNasaFavoritesViewController {
    func setImageandColorForButton(color: UIColor, button: UIButton) {
        let tintedImage = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = color
        button.setImage(tintedImage, for: .normal)
    }
}

extension ApiNasaFavoritesViewController: CustomTableViewControllerDeleagte {
    func setInfo(item: ItemDefault) {
        self.presenter?.setInfo(info: item)
    }
    
    func deleteInfo(item: ItemDefault) {
        self.presenter?.deletInfo(info: item)
    }
    
    func accessToDetail(item: ItemDefault) {
        self.presenter?.navigateToApiNasaDetail(item: item)
    }
}
