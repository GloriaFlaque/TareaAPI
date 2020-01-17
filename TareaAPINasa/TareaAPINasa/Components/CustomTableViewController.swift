//
//  CustomTableViewController.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 15/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import UIKit

protocol CustomTableViewControllerDeleagte {
    func accessToDetail(item: ItemDefault)
    
    func setInfo(item: ItemDefault)
    
    func deleteInfo(item: ItemDefault)
}

class CustomTableViewController: UITableViewController {
    var items: [ItemDefault] = []
    var delegate: CustomTableViewControllerDeleagte?
    
    init(items: [ItemDefault]) {
        self.items = items
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NasaCell = tableView.dequeueReusableCell(withIdentifier: "nasaCell", for: indexPath) as! NasaCell
        let info = items[indexPath.row]
        cell.index = indexPath.row
        cell.delegate = self
        cell.info = info
        cell.customTable()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.accessToDetail(item: items[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133.0
    }
}

extension CustomTableViewController: NasaCellDelegate {
    func starTap(index: Int, select: Bool) {
        if select == false {
            items[index].favorite = true
            self.delegate?.setInfo(item: items[index])
            } else {
            items[index].favorite = false
            self.delegate?.deleteInfo(item: items[index])
        }
    }
}
