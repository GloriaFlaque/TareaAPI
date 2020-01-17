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
    @IBOutlet weak var starButton: UIButton!
    var search: String!
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
    
    @IBAction func clickFavorites(sender: UIButton) {
        if starButton.isSelected == false {
            self.setImageandColorForButton(color: .black, button: starButton)
            self.presenter?.setInfo(info: self.presenter!.item)
            starButton.isSelected = true
            self.presenter?.showApiInfo(searchText: search)
        } else {
            self.setImageandColorForButton(color: .gray, button: starButton)
            self.presenter?.deletInfo(info: self.presenter!.item)
            starButton.isSelected = false
            if search != nil {
                self.presenter?.showApiInfo(searchText: search)
            }
        }
    }
}

extension ApiNasaDetailViewController: ApiNasaDetailView {
    func show(item: ItemDefault) {
        for i in item.data {
            self.titleLabel.text = i.title
            self.descriptionLabel.text = "Location: \( i.location)\nDate: \(i.date_created)\nExplanation: \(i.description)\n\(i.description_508)"
        }
        for i in item.links {
            if i.href.contains("video") {
                self.nasaImg.image = UIImage(named: "nasa")
            } else {
                let url = URL(string: i.href)
                    self.nasaImg.kf.setImage(with: url)
            }
        }
    }
    
    func setupUI() {
        if self.presenter?.item.favorite == true {
            self.setImageandColorForButton(color: .black, button: starButton)
            self.starButton.isSelected = true
        } else {
            self.setImageandColorForButton(color: .gray, button: starButton)
        }
    }
}

private extension ApiNasaDetailViewController {
    func setImageandColorForButton(color: UIColor, button: UIButton) {
        let tintedImage = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = color
        button.setImage(tintedImage, for: .normal)
    }
}
