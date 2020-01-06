//
//  ApiNasaDetailViewController.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 27/12/2019.
//  Copyright © 2019 Gloria Flaqué García. All rights reserved.
//

import UIKit

class ApiNasaDetailViewController: UIViewController {
    @IBOutlet weak var nasaImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
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
    func show(day: [Info]) {
        print("seeeeeeee")
        for i in day {
            self.titleLabel.text = i.title
            self.dateLabel.text = i.date
            self.descriptionLabel.text = i.explanation
            let url = URL(string: i.hdurl)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url!){
                    if let image = UIImage(data: data){
                        DispatchQueue.main.async {
                            self.nasaImg.image = image
                        }
                    }
                }
            }
        }
    }
}
