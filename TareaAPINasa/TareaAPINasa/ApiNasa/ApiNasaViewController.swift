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
    var days = ["2018-08-04", "2018-08-03", "2018-08-02", "2018-08-01", "2018-03-04", "2020-01-02"]
    var listInfo = [[Info]]() {
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
        for i in days {
            self.presenter?.showApiDayInfo(conceptCode: i)
        }
        
//        for i in days{
//            let infoRequest = ApiNasaRequest(dateCode: i)
//            infoRequest.getData { [weak self] result in
//                switch result{
//                case .failure(let error):
//                    print(error)
//                case .success(let info):
//                    self?.listInfo.append(info)
//                }
//            }
//        }
    }
}

extension ApiNasaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return listInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ApiNasaCell = tableView.dequeueReusableCell(withIdentifier: "apiNasaCell", for: indexPath) as! ApiNasaCell
            let info = listInfo[indexPath.row]
            for i in info{
                cell.activityIndicator.hidesWhenStopped = true
                cell.activityIndicator.startAnimating()
                cell.titleLabel.text = i.title
                cell.dateLabel.text = i.date
                let url = URL(string: i.hdurl)
                cell.nasaImg.kf.setImage(with: url)
                cell.activityIndicator.stopAnimating()
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.presenter?.navigateToApiNasaDetail(day: listInfo[indexPath.row])
    }
}
