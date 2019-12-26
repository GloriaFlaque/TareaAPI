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
    @IBOutlet weak var searchBar: UISearchBar!
       
    var presenter: ApiNasaPresenter?
    var days = ["2019-01-01", "2019-14-02", "2019-03-03", "2019-04-04"]
    var listInfo = [Info]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ApiNasaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return listInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ApiNasaCell = tableView.dequeueReusableCell(withIdentifier: "apiNasaCell", for: indexPath) as! ApiNasaCell
        let info = listInfo[indexPath.row]
            cell.titleLabel.text = info.title
        cell.descriptionLabel.text = info.date
        let url = URL(string: info.hdurl)
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        print("hvjhvjhvhjhvhjvjhvjhhvjhjv")
                        cell.nasaImg.image = image
                    }
                }
            }
        }
        return cell
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
