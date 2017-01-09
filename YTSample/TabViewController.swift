//
//  TabViewController.swift
//  YTSample
//
//  Created by robert john alkuino on 1/9/17.
//  Copyright © 2017 thousandminds. All rights reserved.
//

import UIKit

class TabViewController: UIViewController {
    
    let mainNavigationController: UINavigationController

    
    required init() {
        mainNavigationController = MainNavigationController()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addChildViewController(mainNavigationController)
        self.view.addSubview(mainNavigationController.view)
        
        
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
