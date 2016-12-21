//
//  NavigationController.swift
//  national-adventure-poc
//
//  Created by Adam Goth on 12/20/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barTintColor = forestGreen
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }

}
