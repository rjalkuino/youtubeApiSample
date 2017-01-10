//
//  MainNavigationController.swift
//  YTSample
//
//  Created by robert john alkuino on 1/9/17.
//  Copyright © 2017 thousandminds. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    let mainViewController = ViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        pushViewController(mainViewController, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
