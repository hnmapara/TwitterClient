//
//  HamburgerViewController.swift
//  SimpleTwitter
//
//  Created by Harshit Mapara on 11/6/16.
//  Copyright © 2016 Harshit Mapara. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    
    var originalLeftMargin : CGFloat!
    
    var menuViewController: UIViewController! {
        didSet {
            //call any method on view just to invoke view inflate
            view.layoutIfNeeded()
            menuView.addSubview(menuViewController.view)
        }
    }
    
    var contentViewController : UIViewController! {
        didSet(oldContentViewController) {
            //call any method on view just to invoke view
            view.layoutIfNeeded()
            
            if oldContentViewController != nil {
                oldContentViewController.willMove(toParentViewController: nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMove(toParentViewController: nil)
            }
            
            contentViewController.willMove(toParentViewController: self)
            contentViewController.didMove(toParentViewController: self)
            
            contentView.addSubview(contentViewController.view)
            
            //Close drawer with animation
            UIView.animate(withDuration: 0.3) { 
                self.leftMarginConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            originalLeftMargin = leftMarginConstraint.constant
        } else if sender.state == UIGestureRecognizerState.changed {
            leftMarginConstraint.constant = originalLeftMargin + translation.x
        } else if sender.state == UIGestureRecognizerState.ended {
            //Add animation
            
            UIView.animate(withDuration: 0.3, animations: {
                //Close or Open drawer
                if velocity.x > 0 {
                    //opening drawer
                    self.leftMarginConstraint.constant = self.view.frame.size.width - 50
                } else {
                    //closing drawer
                    self.leftMarginConstraint.constant = 0
                }
                
                self.view.layoutIfNeeded()
            })
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
