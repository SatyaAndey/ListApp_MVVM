//
//  ListControllerTableViewDataSource.swift
//  ListApp
//
//  Created by Satya on 12/11/20.
//  Copyright © 2020 Satya. All rights reserved.
//

import UIKit
import Kingfisher

class ListControllerTableViewDataSource: NSObject, UITableViewDataSource {
    
    var listItems = [List.APIList.ViewModel]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as? ListTableViewCell ?? ListTableViewCell()
        self.configureData(cell, model: listItems[indexPath.row])
        return cell
    }
    
    // Data mapping
    
    func configureData(_ cell: ListTableViewCell,  model: List.APIList.ViewModel) {
        cell.lblTitile.text = model.title ?? ""
        cell.lblDescription.text = model.description ?? ""
        if let imgUrl = model.imageHref, let url = URL(string: imgUrl) {
            cell.imgView.kf.indicatorType = .activity
            cell.imgView.kf.setImage(with: url, placeholder:  UIImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: { ( _ ,  _,  _,  _) in
                DispatchQueue.main.async {
                    cell.imgView.layer.cornerRadius = cell.imgView.frame.size.width / 2
                    
                }
            })
        } else {
            cell.imgView.image = UIImage(named: "placeholder")
        }
    }
    
    
}
