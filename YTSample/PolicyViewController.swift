//
//  PolicyViewController.swift
//  YTSample
//
//  Created by robert john alkuino on 1/10/17.
//  Copyright © 2017 thousandminds. All rights reserved.
//

import UIKit
import MMDrawerController

class PolicyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "BurgerMenu"), style: .plain, target: self, action: #selector(openDrawer))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openDrawer() {
        self.mm_drawerController.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }

}
