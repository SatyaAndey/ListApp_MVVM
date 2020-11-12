//
//  ListControllerTableViewDataSource.swift
//  ListApp
//
//  Created by Satya on 12/11/20.
//  Copyright © 2020 Satya. All rights reserved.
//

import UIKit

class ListControllerTableViewDataSource: NSObject, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as? ListTableViewCell ?? ListTableViewCell()
        cell.lblTitile.text = "Title"
        cell.lblDescription.text = "hjhsgjhsdjjkshgkjsdhkjghskghkshgjkshjkghskjhgkjshgkjhskjghkj"
        cell.imgView?.image = UIImage(named: "placeholder")
        return cell
    }
    

}
