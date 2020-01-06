//
//  ApiNasaViewController.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 23/12/2019.
//  Copyright © 2019 Gloria Flaqué García. All rights reserved.
//

import UIKit

class ApiNasaViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
       
    let searchController = UISearchController(searchResultsController: nil)
    var presenter: ApiNasaPresenter?
    var days = ["2018-08-04", "2018-08-03", "2018-08-02", "2018-08-01", "1999-08-04"]
    var listInfoT = [[Info]]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var listInfo = [Info]() {
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
    func setupUI() {
//        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar..."
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        for i in days{
            print(i)
            let infoRequest = ApiNasaRequest(dateCode: i)
            infoRequest.getData { [weak self] result in
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let info):
                    self?.listInfoT.append(info)
                }
            }
        }
    }
}

extension ApiNasaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return listInfoT.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ApiNasaCell = tableView.dequeueReusableCell(withIdentifier: "apiNasaCell", for: indexPath) as! ApiNasaCell
            let info = listInfoT[indexPath.row]
            for i in info{
                cell.titleLabel.text = i.title
                cell.dateLabel.text = i.date
                let url = URL(string: i.hdurl)
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url!){
                        if let image = UIImage(data: data){
                            DispatchQueue.main.async {
                                cell.nasaImg.image = image
                            }
                        }
                    }
                }
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.presenter?.navigateToApiNasaDetail(day: listInfoT[indexPath.row])
    }
}

extension ApiNasaViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {return}
        let infoRequest = ApiNasaRequest(dateCode: searchBarText)
        infoRequest.getData { [weak self] result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let info):
                self?.listInfo = info
            }
        }
    }
}
