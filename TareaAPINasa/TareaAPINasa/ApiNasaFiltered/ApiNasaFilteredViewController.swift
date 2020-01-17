//
//  ApiNasaFilteredViewController.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 04/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import UIKit
import Kingfisher

class ApiNasaFilteredViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var search: String!
    var customTableView: CustomTableViewController?
       
    let searchController = UISearchController(searchResultsController: nil)
    var presenter: ApiNasaFilteredPresenter?
    var collectionlist = [ItemDefault]() {
        didSet {
            DispatchQueue.main.async {
                self.customTableView!.items = self.collectionlist
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
}
extension ApiNasaFilteredViewController: ApiNasaFilteredView {
    func setupUI() {
        tableView.register(UINib(nibName: "NasaCell", bundle: nil), forCellReuseIdentifier: "nasaCell")
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.placeholder = "Search..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        self.customTableView = CustomTableViewController(items: collectionlist)
        self.customTableView?.delegate = self
        self.tableView.dataSource = self.customTableView!
        self.tableView.delegate = self.customTableView!
    }
    
    func passInfo(info: [ItemDefault]) {
        self.collectionlist = info
    }
}

extension ApiNasaFilteredViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {return}
        self.presenter?.showApiImageInfo(searchText: searchBarText)
        self.search = searchBarText
    }
}

extension ApiNasaFilteredViewController: CustomTableViewControllerDeleagte {
    func setInfo(item: ItemDefault) {
        self.presenter?.setInfo(info: item)
    }
    
    func deleteInfo(item: ItemDefault) {
        self.presenter?.deletInfo(info: item)
    }
    
    func accessToDetail(item: ItemDefault) {
        self.presenter?.navigateToApiNasaDetail(info: item)
    }
}
