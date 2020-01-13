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
       
    let searchController = UISearchController(searchResultsController: nil)
    var presenter: ApiNasaFilteredPresenter?
    var collectionlist = [ItemDetails]() {
        didSet {
            DispatchQueue.main.async {
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
    }
    
    func passInfo(info: [ItemDetails]) {
            self.collectionlist = info
        }
}

extension ApiNasaFilteredViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return collectionlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NasaCell = tableView.dequeueReusableCell(withIdentifier: "nasaCell", for: indexPath) as! NasaCell
        let info = collectionlist[indexPath.row]
            cell.activityIndicator.hidesWhenStopped = true
            cell.activityIndicator.startAnimating()
            for i in info.data {
                cell.titleLabel.text = i.title
                cell.dateLabel.text = i.date_created
            }
            for i in info.links {
                if i.href.contains("video") {
                    cell.nasaImg.image = UIImage(named: "nasa")
                } else {
                    let url = URL(string: i.href)
                    cell.nasaImg.kf.setImage(with: url)
                    cell.activityIndicator.stopAnimating()
                }
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.presenter?.navigateToApiNasaDetail(day: [collectionlist[indexPath.row]])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133.0
    }
}

extension ApiNasaFilteredViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {return}
        self.presenter?.showApiImageInfo(searchText: searchBarText)
    }
}
