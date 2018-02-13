//
//  ViewConrellerTableExtension.swift
//  whatappstatusclone
//
//  Created by Tibin Thomas on 13/02/18.
//  Copyright © 2018 tibinT9. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate{
    
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.detailTextLabel?.text = "hai"
        cell.textLabel?.text = "Hell\(indexPath.row)"
        cell.imageView?.image = UIImage(named: "whatsappbomb")
        return cell
    }
}

