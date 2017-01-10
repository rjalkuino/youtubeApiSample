//
//  TabViewController.swift
//  YTSample
//
//  Created by robert john alkuino on 1/9/17.
//  Copyright © 2017 thousandminds. All rights reserved.
//

import UIKit
import MMDrawerController

class TabViewController: UIViewController {
    let mainDrawerController = MMDrawerController()

    required init() {
        
        mainDrawerController.centerViewController = MainNavigationController()
        mainDrawerController.leftDrawerViewController = DrawerViewController()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(mainDrawerController.centerViewController.view)
        self.view.addSubview(mainDrawerController.leftDrawerViewController.view)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
