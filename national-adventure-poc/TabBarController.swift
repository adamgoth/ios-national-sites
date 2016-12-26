//
//  TabBarController.swift
//  national-adventure-poc
//
//  Created by Adam Goth on 12/20/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Sets the default color of the icon of the selected UITabBarItem and Title
        UITabBar.appearance().tintColor = UIColor.white
        
        // Sets the default color of the background of the UITabBar
        UITabBar.appearance().barTintColor = forestGreen
        
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "OpenSans", size: 10)!], for: .normal)
        
    }

}
