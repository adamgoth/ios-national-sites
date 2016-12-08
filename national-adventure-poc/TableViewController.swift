//
//  TableViewController.swift
//  national-adventure-poc
//
//  Created by Adam Goth on 12/1/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var selectedSiteTypes: [Location.SiteType]!
    var sitesList = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSitesList()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(filterSiteTypes))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setSitesList()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sitesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = sitesList[indexPath.row].title
        return cell
    }
    
    func filterSiteTypes() {
        performSegue(withIdentifier: "showSitesFilter", sender: self)
    }
    
    func setSitesList() {
        sitesList = [Location]()
        let defaults = UserDefaults.standard
        if let previousFilter = defaults.object(forKey: "filteredSiteTypes") as? [String] {
            let mappedSites = previousFilter.map { return Location.SiteType(rawValue: $0)! }
            selectedSiteTypes = mappedSites
        } else {
            selectedSiteTypes = DataService.allSiteTypes
        }
        
        for siteType in selectedSiteTypes {
            for park in DataService.allLocations.filter({ return $0.siteType == siteType }) {
                sitesList.append(park)
            }
        }
        
        sitesList.sort(by: { $0.title! < $1.title! })
    }
    

}
