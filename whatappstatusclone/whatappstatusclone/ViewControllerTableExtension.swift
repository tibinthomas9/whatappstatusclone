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
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "HeaderDefault")
        cell.detailTextLabel?.text = "hai"
        cell.textLabel?.text = "Hell\(indexPath.row)"
        cell.imageView?.image = UIImage(named: "whatsappbomb")
        return cell
    }
}

