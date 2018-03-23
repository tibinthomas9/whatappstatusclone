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
        case any
        case bottomAttached // The bar is at the bottom of its local context, and directional decoration draws accordingly (e.g., shadow above the bar).
        case topAttached // The bar is at the top of the screen (as well as its local context), and its background extends upward—currently only enough for the status bar.
    }
    
    func showToast(message : NSAttributedString ,color : UIColor = UIColor.black,textColor : UIColor = UIColor.white, position: ToastPosition = .any,size : CGSize? = nil){
        //insert the toastView
        let toastView = UILabel()
        toastView.translatesAutoresizingMaskIntoConstraints = false
        toastView.alpha = 0.8
        toastView.font = UIFont.systemFont(ofSize: 12)
        toastView.minimumScaleFactor = 0.5
        toastView.adjustsFontSizeToFitWidth = true
        toastView.numberOfLines = 0
        toastView.attributedText = message
        toastView.textAlignment = .center
        toastView.textColor = textColor
        toastView.backgroundColor = color
        view.addSubview(toastView)
        view.bringSubview(toFront: toastView)
        //setting constraints
        
        // width and height
        toastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (position == .any ) ? view.bounds.width/7: 0 ).isActive = true
        toastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: position == .any ?  -view.bounds.width/7 : 0).isActive = true
        var heightConstraint = toastView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint.isActive = true
        
        // position the toast
        switch position {
        case .topAttached:
            if #available(iOS 11.0, *) {
                toastView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            }
            else{
                toastView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            }
        default:
            if #available(iOS 11.0, *) {
                toastView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: position == .bottomAttached ? 0: -view.bounds.height/7).isActive = true
            }
            else{
                toastView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  position == .bottomAttached ? 0: -view.bounds.height/7).isActive = true
            }

        }
        self.view.layoutIfNeeded()
        heightConstraint.isActive = false
        heightConstraint = toastView.heightAnchor.constraint(greaterThanOrEqualToConstant:  0)
        heightConstraint.isActive = true
        //animate increase height
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
            //animate dimming after 1 second
            UIView.animate(withDuration: 1, delay: 1, options:.curveEaseInOut, animations: {
                toastView.alpha = 0
                }, completion: { (completed) in
                    toastView.removeFromSuperview()
                })

        }
    }
    
}
