//
//  ApiNasaFilteredViewController.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 04/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import UIKit

class ApiNasaFilteredViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
       
    let searchController = UISearchController(searchResultsController: nil)
    var presenter: ApiNasaFilteredPresenter?
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
}
extension ApiNasaFilteredViewController: ApiNasaFilteredView {
    func setupUI() {
    }
}

extension ApiNasaFilteredViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return listInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ApiNasaFilteredCell = tableView.dequeueReusableCell(withIdentifier: "apiNasaFilteredCell", for: indexPath) as! ApiNasaFilteredCell
            let info = listInfo[indexPath.row]
            cell.titleLabel.text = info.title
            cell.dateLabel.text = info.date
            let url = URL(string: info.hdurl)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url!){
                    if let image = UIImage(data: data){
                        DispatchQueue.main.async {
                            cell.nasaImg.image = image
                        }
                    }
                }
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.presenter?.navigateToApiNasaDetail(day: [listInfo[indexPath.row]])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133.0
    }
}

extension ApiNasaFilteredViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {return}
        let infoRequest = ApiNasaRequest(dateCode: searchBarText)
        infoRequest.getData { [weak self] result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let info):
                self?.listInfo = info
                print(info)
            }
        }
    }
}
