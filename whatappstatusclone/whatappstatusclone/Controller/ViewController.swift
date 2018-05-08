//
//  ViewController.swift
//  whatappstatusclone
//
//  Created by Tibin Thomas on 01/02/18.
//  Copyright © 2018 tibinT9. All rights reserved.
//

import UIKit
enum Direction {
    case up
    case down
    case no
}
class ViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var headerImgView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var draggerView: UIView!
    @IBOutlet weak var draggerDetail: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentHeader: UIView!
    @IBOutlet weak var tableView: wscTableView!
    @IBOutlet weak var draggerBottom: NSLayoutConstraint!
    @IBOutlet weak var heightTable: NSLayoutConstraint!
    var viewCount:Int = 0{
        didSet{
            draggerDetail.text = "\(viewCount)"
            tableView.reloadData()
        }
    }
    var lastLocation: CGFloat = 0
    var oldContentOffset = CGPoint.zero
    var draggerBottomConstant:CGFloat = 0{
        didSet{
         draggerBottom.constant = draggerBottomConstant
            self.view.layoutIfNeeded()
            if   draggerBottomConstant < -39{
                if (contentView.alpha != 1){
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                    self.contentView.alpha = 1
                }, completion: nil)
                }
            }
            else{
                contentView.alpha = 0
        //  contentView.alpha =  draggerBottomConstant < -39 ? 1 : 0
            }
        }
    }
    var tableViewHeight: CGFloat {
        tableView.layoutIfNeeded()
        return tableView.contentSize.height
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = "Toast"
        details.text = "ended"
        headerImgView.image = UIImage(named: "whatsappbomb")
        headerImgView.round(withBorder: true)
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.alwaysBounceVertical = false
       // tableView.bounces = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    updateTable()
        self.showToast(message: NSAttributedString(string: "\n\nHai\n\n"), size: nil)
    }
    func updateTable(){
        viewCount = 50
        if (tableViewHeight <= (-getMaxDraggerBottom() - 80))
        {
            heightTable.constant = tableViewHeight
        }
        else{
            heightTable.constant = (-getMaxDraggerBottom() - 80)
        }
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // heightTable.constant = tableViewHeight <= (getMaxDraggerBottom() - 40)  ? tableViewHeight : (getMaxDraggerBottom() - 40)

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //super.touchesBegan(touches, with: event)
        lastLocation = draggerBottom.constant
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
//                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
//        -> Bool {
//            return true
//    }
    
    
    @IBAction func panAction(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        draggerBottomConstant = lastLocation + translation.y
        draggerView.alpha =  (getMaxDraggerBottom() - draggerBottom.constant) / getMaxDraggerBottom()
        if sender.state == UIGestureRecognizerState.began {
            
        } else if sender.state == UIGestureRecognizerState.changed {
            
        } else if sender.state == UIGestureRecognizerState.ended {

            tableView.isUserInteractionEnabled = true
            if velocity.y > 0 {
                moveToBottom()
            } else {
                moveToTop()
                }

            }
        }
    
    func moveToBottom(){
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.draggerBottomConstant = 0
            self.draggerView.alpha = 1
            self.view.layoutIfNeeded()
        }){ (completed) in
            self.showToast(message: NSAttributedString(string: "DOWN"), position: .bottomAttached, size: nil)
        }
    }
    func moveToTop(){
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.draggerBottomConstant = self.getMaxDraggerBottom()
            self.draggerView.alpha = 0
            self.view.layoutIfNeeded()
        }) { (completed) in
            self.showToast(message: NSAttributedString(string: "\nUP\n") , position: .default, size: nil)
            self.showToast(message: NSAttributedString(string: "\nUP\n") , color : UIColor.red, position: .topAttached)
        }
    }
    
func getMaxDraggerBottom() ->  CGFloat{
    if #available(iOS 11.0, *) {
        let guide = view.safeAreaLayoutGuide
            return -(guide.layoutFrame.height - self.headerImgView.frame.height) + 100
        
    } else {
        // Fallback on earlier versions
            return  -(self.view.frame.height - self.headerImgView.frame.height) + 100
    }
    
}
    
}
//MARK:- Helpers
extension UIView{
    func round(withBorder:Bool = false){
        clipsToBounds = true
        layer.cornerRadius = self.frame.height/2
        if (withBorder){
            layer.borderWidth = 1
            layer.borderColor = UIColor.black.cgColor
        }
    }
 
}
extension wscTableView{
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if (self.contentOffset.y < 1 && self.panGestureRecognizer.velocity(in: self.superview).y > 0){
          return false
        }
        return super.point(inside: point, with: event)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if (self.contentOffset.y < 1  && self.direction != .up){
            self.superview?.superview?.touchesBegan(touches, with: event)
        }
        else{
            self.canCancelContentTouches = true
            self.touchesCancelled(touches, with: event)
           // self.delaysContentTouches = true
            self.isScrollEnabled = true
            //self.next?.touchesBegan(touches, with: event)
        }
    //    super.touchesBegan(touches, with: event)
    }
    override func touchesShouldBegin(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) -> Bool {
        
            return true
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let touch = touches.first{
            if (touch.location(in: self).y - touch.previousLocation(in: self).y > 0) {
                self.direction = .down
                
            } else {
                self.direction = .up
            }
            if (self.contentOffset.y < 1  && self.direction != .up){
                self.touchesCancelled(touches, with: event)
                self.superview?.superview?.touchesBegan(touches, with: event)
            }
            else{
               // self.delaysContentTouches = true
                self.isScrollEnabled = true
                //self.next?.touchesBegan(touches, with: event)
                // self.touchesBegan(touches, with: event)
            }

        }
    }
}

