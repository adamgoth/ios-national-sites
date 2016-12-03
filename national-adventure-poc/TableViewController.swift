//
//  TableViewController.swift
//  national-adventure-poc
//
//  Created by Adam Goth on 12/1/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.allNationalParks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = DataService.allNationalParks[indexPath.row].title
        return cell
    }

}
