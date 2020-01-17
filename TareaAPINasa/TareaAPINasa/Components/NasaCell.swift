//
//  NasaCell.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 12/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import UIKit

protocol NasaCellDelegate {
    
    func starTap(index: Int, select: Bool)
}

class NasaCell: UITableViewCell {
    var delegate: NasaCellDelegate?
    var index: Int?
    var info: ItemDefault?
    var select = false
    
    @IBOutlet weak var nasaImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func clickFavorites(sender: UIButton) {
        guard let favIndex = self.index else { return }
        if starButton.isSelected == false {
            self.setImageandColorForButton(color: .black, button: starButton)
            starButton.isSelected = true
            select = false
        } else {
            self.setImageandColorForButton(color: .gray, button: starButton)
            starButton.isSelected = false
            select = true
        }
        self.delegate?.starTap(index: favIndex, select: select)
    }
    
    func customTable(){
        if info!.favorite == true {
            self.setImageandColorForButton(color: .black, button: starButton)
            self.starButton.isSelected = true
        } else {
            self.setImageandColorForButton(color: .gray, button: starButton)
            self.starButton.isSelected = false
        }
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.startAnimating()
        for i in info!.data {
            self.titleLabel.text = i.title
            self.dateLabel.text = i.date_created
        }
        for i in info!.links {
            if i.href.contains("video") {
                self.nasaImg.image = UIImage(named: "nasa")
                self.activityIndicator.stopAnimating()
            } else {
                let url = URL(string: i.href)
                self.nasaImg.kf.setImage(with: url)
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func setImageandColorForButton(color: UIColor, button: UIButton) {
        let tintedImage = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = color
        button.setImage(tintedImage, for: .normal)
    }
}
