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
    
    var apiInteractor: ApiNasaImageInteractor!
    var collectionlist = [ItemsDatails]() {
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
//        searchController.searchResultsUpdater = self as! UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.placeholder = "Search..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension ApiNasaFilteredViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return collectionlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: ApiNasaFilteredCell = tableView.dequeueReusableCell(withIdentifier: "apiNasaFilteredCell", for: indexPath) as! ApiNasaFilteredCell

        let info = collectionlist[indexPath.row]
            cell.activityIndicator.hidesWhenStopped = true
            cell.activityIndicator.startAnimating()
            for i in info.data {
                cell.titleLabel.text = i.title
                cell.dateLabel.text = i.date_created
            }
            for i in info.links {
                print(i.href)
                let url = URL(string: i.href)
                cell.nasaImg.kf.setImage(with: url)
                cell.activityIndicator.stopAnimating()
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
        self.presenter?.showApiImageInfo(conceptCode: searchBarText)
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange seachText: String) {
////        guard let searchBarText = seachText else {return}
//        self.presenter?.showApiImageInfo(conceptCode: seachText)
//    }
}


//extension ApiNasaFilteredViewController: UISearchResultsUpdating {
//    func updateSearchResults(for sender: UISearchController) {
//        guard let searchBarText = searchController.searchBar.text else {return}
//        self.presenter?.showApiImageInfo(conceptCode: searchBarText)
//    }
//}
