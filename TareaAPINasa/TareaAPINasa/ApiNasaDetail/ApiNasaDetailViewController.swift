//
//  ApiNasaDetailViewController.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import UIKit
import Kingfisher

class ApiNasaDetailViewController: UIViewController {
    @IBOutlet weak var nasaImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var presenter: ApiNasaDetailPresenter?

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

extension ApiNasaDetailViewController: ApiNasaDetailView {
    func show(item: [ItemDetails]) {
        for i in item {
            for i in i.data {
                self.titleLabel.text = i.title
                self.descriptionLabel.text = "Location: \( i.location)\nDate: \(i.date_created)\nExplanation: \(i.description)\n\(i.description_508)"
            }
            for i in i.links {
                if i.href.contains("video") {
                    self.nasaImg.image = UIImage(named: "nasa")
                } else {
                    let url = URL(string: i.href)
                        self.nasaImg.kf.setImage(with: url)
                }
            }
        }
    }
}
