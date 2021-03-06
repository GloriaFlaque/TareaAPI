//
//  ApiNasaViewController.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 23/12/2019.
//  Copyright © 2019 Gloria Flaqué García. All rights reserved.
//

import UIKit
import Kingfisher

class ApiNasaViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    var customTableView: CustomTableViewController?
    
    let searchController = UISearchController(searchResultsController: nil)
    var presenter: ApiNasaPresenter?
    var listInfo = [ItemDefault]() {
        didSet {
            DispatchQueue.main.async {
                self.customTableView!.items = self.listInfo
                self.tableView.reloadData()
            }
        }
    }
    
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
    
    @IBAction func clickFilter(sender: UIButton) {
        self.presenter?.navigateToApiNasaSearch()
    }
    
    @IBAction func clickFavorites(sender: UIButton) {
        self.presenter?.navigateToApiNasaFavorites()
    }
}

extension ApiNasaViewController: ApiNasaView {
    func passInfo(info: [ItemDefault]) {
        self.listInfo = info
    }
    
    func setupUI() {
        tableView.register(UINib(nibName: "NasaCell", bundle: nil), forCellReuseIdentifier: "nasaCell")
        self.presenter?.showApiInfo(searchText: "Sun")
        self.customTableView = CustomTableViewController(items: listInfo)
        self.customTableView?.delegate = self
        self.tableView.dataSource = self.customTableView!
        self.tableView.delegate = self.customTableView!
    }
    
    func table(info: [ItemDefault]) {
        self.listInfo = info
    }
}

private extension ApiNasaViewController {
    func setImageandColorForButton(color: UIColor, button: UIButton) {
        let tintedImage = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = color
        button.setImage(tintedImage, for: .normal)
    }
}

extension ApiNasaViewController: CustomTableViewControllerDeleagte {
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
