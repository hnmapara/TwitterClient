//
//  MenuViewController.swift
//  SimpleTwitter
//
//  Created by Harshit Mapara on 11/6/16.
//  Copyright © 2016 Harshit Mapara. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var homeTimeLineNavigationViewController : UINavigationController!
    private var mentionTimeLineNavigationViewController : UINavigationController!
    private var profileViewController : UIViewController!

    var viewControllers : [UIViewController] = []
    var hamburgerViewContoller : HamburgerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        homeTimeLineNavigationViewController = storyBoard.instantiateViewController(withIdentifier: "TweetsNavigationController") as! UINavigationController
        let homeTweetVC = homeTimeLineNavigationViewController.topViewController as! TweetsViewController
        homeTweetVC.isHomeTimeline = true
        homeTweetVC.isMentionsTimeline = false
        
        
        mentionTimeLineNavigationViewController = storyBoard.instantiateViewController(withIdentifier: "TweetsNavigationController") as! UINavigationController
        let mentionVC = mentionTimeLineNavigationViewController.topViewController as! TweetsViewController
        mentionVC.isHomeTimeline = false
        mentionVC.isMentionsTimeline = true

        
        profileViewController = storyboard!.instantiateViewController(withIdentifier: "profileViewController")
        
        viewControllers.append(homeTimeLineNavigationViewController)
        viewControllers.append(mentionTimeLineNavigationViewController)
        viewControllers.append(profileViewController)
        
        hamburgerViewContoller.contentViewController = profileViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuViewCell
        
        let titles = ["Home", "Mentions", "Profile"]
        cell.ItemLabel.text = titles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        hamburgerViewContoller.contentViewController = self.viewControllers[indexPath.row]
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
