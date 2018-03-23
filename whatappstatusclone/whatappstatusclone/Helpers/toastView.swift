//
//  toastView.swift
//  whatappstatusclone
//
//  Created by Tibin Thomas on 22/03/18.
//  Copyright © 2018 tibinT9. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    public enum ToastPosition : Int {
        case `default`
        case bottomAttached // The bar is at the bottom of its local context, and directional decoration draws accordingly (e.g., shadow above the bar).
        case topAttached // The bar is at the top of the screen (as well as its local context), and its background extends upward—currently only enough for the status bar.
    }
    
    func showToast(message : NSAttributedString ,color : UIColor = UIColor.lightGray,textColor : UIColor = UIColor.white, position: ToastPosition = .default,size : CGSize? = nil){
        //insert the toastView
        let container = UIView()
        let toastView = UILabel()
        container.translatesAutoresizingMaskIntoConstraints = false
        toastView.translatesAutoresizingMaskIntoConstraints = false
        toastView.alpha = 0.8
        toastView.font = UIFont.systemFont(ofSize: 13)
        toastView.minimumScaleFactor = 0.5
        toastView.adjustsFontSizeToFitWidth = true
        toastView.numberOfLines = 0
        toastView.attributedText = message
        toastView.textAlignment = .center
        toastView.textColor = textColor
        toastView.backgroundColor = color
        toastView.layer.masksToBounds = true
        container.layer.masksToBounds = false
        container.layer.shadowOpacity = 0.5
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowRadius = 8
        container.layer.shadowOffset = CGSize(width: 0, height: 0)

        view.addSubview(container)
        container.addSubview(toastView)
        view.bringSubview(toFront: container)
        //setting constraints
        
        // width and height
        container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (position == .default ) ? view.bounds.width/7: 0 ).isActive = true
        container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: position == .default ?  -view.bounds.width/7 : 0).isActive = true
        var heightConstraint = container.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint.isActive = true
        //constraining toastview within container
        toastView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        toastView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        toastView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        toastView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true

        
        // position the toast
        switch position {
        case .topAttached:
            if #available(iOS 11.0, *) {
                container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            }
            else{
                container.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            }
        default:
            if #available(iOS 11.0, *) {
                container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: position == .bottomAttached ? 0: -view.bounds.height/9).isActive = true
            }
            else{
                container.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  position == .bottomAttached ? 0: -view.bounds.height/9).isActive = true
            }

        }
        
        self.view.layoutIfNeeded()
        
        heightConstraint.isActive = false
        heightConstraint = container.heightAnchor.constraint(greaterThanOrEqualToConstant:  0)
        heightConstraint.isActive = true
        
        //animate increase height
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
            if (position == .default){
                toastView.layer.cornerRadius = toastView.bounds.height/3
            }
        }) { (completed) in
            //animate dimming after 1 second
            UIView.animate(withDuration: 1, delay: 1, options:.curveEaseInOut, animations: {
                toastView.alpha = 0
                }, completion: { (completed) in
                    container.removeFromSuperview()
                })

        }
    }
    
}
