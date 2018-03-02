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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let delta =  scrollView.contentOffset.y - oldContentOffset.y
        if (delta < 0 && scrollView.contentOffset.y <= 0){
            scrollView.setContentOffset(CGPoint.zero, animated: false)
            draggerBottomConstant = draggerBottomConstant - delta
            scrollView.delaysContentTouches = false
        }
        if (delta > 0  && self.draggerBottomConstant >= self.getMaxDraggerBottom()){
            scrollView.setContentOffset(CGPoint.zero, animated: false)
            draggerBottomConstant = draggerBottomConstant - delta
        }
        oldContentOffset = scrollView.contentOffset
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if( draggerBottomConstant > self.getMaxDraggerBottom()){
            self.moveToBottom()
        }
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

