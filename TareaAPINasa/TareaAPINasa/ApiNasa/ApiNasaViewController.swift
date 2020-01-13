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
    
    let searchController = UISearchController(searchResultsController: nil)
    var presenter: ApiNasaPresenter?
    var listInfo = [ItemDetails]() {
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
    
    @IBAction func clickFilter(sender: UIButton) {
        self.presenter?.navigateToApiNasaSearch()
    }
}

extension ApiNasaViewController: ApiNasaView {
    func passInfo(info: [ItemDetails]) {
        self.listInfo = info
    }
    
    func setupUI() {
        tableView.register(UINib(nibName: "NasaCell", bundle: nil), forCellReuseIdentifier: "nasaCell")
        self.presenter?.showApiImageInfo(searchText: "Sun")
    }
}

extension ApiNasaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return listInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NasaCell = tableView.dequeueReusableCell(withIdentifier: "nasaCell", for: indexPath) as! NasaCell
            let info = listInfo[indexPath.row]
            cell.activityIndicator.hidesWhenStopped = true
            cell.activityIndicator.startAnimating()
            for i in info.data {
                cell.titleLabel.text = i.title
                cell.dateLabel.text = i.date_created
            }
            for i in info.links {
                if i.href.contains("video") {
                    cell.nasaImg.image = UIImage(named: "nasa")
                    cell.activityIndicator.stopAnimating()
                } else {
                    let url = URL(string: i.href)
                    cell.nasaImg.kf.setImage(with: url)
                    cell.activityIndicator.stopAnimating()
                }
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.presenter?.navigateToApiNasaDetail(item: [listInfo[indexPath.row]])
    }
}
