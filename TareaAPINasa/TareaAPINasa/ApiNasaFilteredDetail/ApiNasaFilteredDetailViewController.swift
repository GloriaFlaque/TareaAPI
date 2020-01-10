//
//  ApiNasaFilteredDetailViewController.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import UIKit
import Kingfisher

class ApiNasaFilteredDetailViewController: UIViewController {
    @IBOutlet weak var nasaImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    var presenter: ApiNasaFilteredDetailPresenter?

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

extension ApiNasaFilteredDetailViewController: ApiNasaFilteredDetailView {
    func show(item: [ItemsDatails]) {
        print("hhhhhh")
        print(item)
            for i in item {
                for i in i.data {
                    self.titleLabel.text = i.title
                    self.locationLabel.text = i.location
                    self.dateLabel.text = "Date: \(i.date_created)\n\(i.description_508)"
                    self.descriptionLabel.text = "Explanation: \(i.description)"
                }
                for i in i.links {
                    let url = URL(string: i.href)
                    DispatchQueue.main.async {
                        self.nasaImg.kf.setImage(with: url)
                    }
                }
            }
        }
}
