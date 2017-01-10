//
//  DrawerViewController.swift
//  YTSample
//
//  Created by robert john alkuino on 1/10/17.
//  Copyright © 2017 thousandminds. All rights reserved.
//

import UIKit
import MMDrawerController

class LeftViewController: UIViewController {

    let tableNav = UITableView()
    let navigationTitles = ["Videos","Riding Policies"]
    let titleView = UILabel()
    var page:String = "videos"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        let labelHeight = view.height * 0.3
        
        titleView.text = "RIDE PH"
        titleView.textColor = UIColor.white
        titleView.font = UIFont.boldSystemFont(ofSize: 40)
        titleView.textAlignment = .center
        titleView.backgroundColor = UIColor.orange
        view.addSubview(titleView)
        titleView.anchorToEdge(.top, padding: 0, width: view.width, height: labelHeight)

        tableNav.delegate = self
        tableNav.dataSource = self
        view.addSubview(tableNav)
        tableNav.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableNav.align(.underMatchingLeft, relativeTo: titleView, padding: 0, width: view.width, height: view.height - labelHeight)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LeftViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        
        let info = navigationTitles[indexPath.row]
        cell.textLabel?.text = info
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension LeftViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return navigationTitles.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item == 0 && page != "videos"{
            
            let navigationController = self.mm_drawerController.centerViewController as! UINavigationController
            navigationController.viewControllers = [ViewController()]
            self.mm_drawerController.toggle(MMDrawerSide.left, animated: true, completion: nil)
            page = "videos"
            
        }
        if indexPath.item == 1 && page != "policies"{
            
            let navigationController = self.mm_drawerController.centerViewController as! UINavigationController
            navigationController.viewControllers = [PolicyViewController()]
            self.mm_drawerController.toggle(MMDrawerSide.left, animated: true, completion: nil)
            page = "policies"
        }
    }
}
