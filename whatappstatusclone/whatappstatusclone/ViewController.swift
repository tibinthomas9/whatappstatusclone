//
//  ViewController.swift
//  whatappstatusclone
//
//  Created by Tibin Thomas on 01/02/18.
//  Copyright © 2018 tibinT9. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var headerImgView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var draggerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var draggerBottom: NSLayoutConstraint!
    var lastLocation: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = "Tibin"
        details.text = "ended"
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastLocation = draggerBottom.constant
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func panAction(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        draggerBottom.constant = lastLocation + translation.y
        if sender.state == UIGestureRecognizerState.began {
            
        } else if sender.state == UIGestureRecognizerState.changed {
            
        } else if sender.state == UIGestureRecognizerState.ended {

            
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.draggerBottom.constant = 0
                })
            } else {
                if #available(iOS 11.0, *) {
                    let guide = view.safeAreaLayoutGuide
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        self.draggerBottom.constant = -(guide.layoutFrame.height - self.headerImgView.frame.height) + 100
                                        })
                } else {
                    // Fallback on earlier versions
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        self.draggerBottom.constant = -(self.view.frame.height - self.headerImgView.frame.height) + 100
                    })
                }

            }
        }
    }
    
}

