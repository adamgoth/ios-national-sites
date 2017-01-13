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
        //UITabBar.appearance().tintColor = UIColor.white
        
        // Sets the default color of the background of the UITabBar
        UITabBar.appearance().barTintColor = forestGreen
        
        //UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "OpenSans", size: 10)!], for: .normal)
        //UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "OpenSans", size: 10)!], for: .selected)
        
        let arrayOfImageNameForSelectedState = ["map-white", "list-white"]
        let arrayOfImageNameForUnselectedState = ["map-darkgray", "list-darkgray"]
        
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                let imageNameForSelectedState   = arrayOfImageNameForSelectedState[i]
                let imageNameForUnselectedState = arrayOfImageNameForUnselectedState[i]
                
                self.tabBar.items?[i].selectedImage = UIImage(named: imageNameForSelectedState)?.withRenderingMode(.alwaysOriginal)
                self.tabBar.items?[i].image = UIImage(named: imageNameForUnselectedState)?.withRenderingMode(.alwaysOriginal)
            }
        }
        
        let selectedColor   = UIColor.white
        let unselectedColor = UIColor.darkGray
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: selectedColor], for: .selected)

    }

}
