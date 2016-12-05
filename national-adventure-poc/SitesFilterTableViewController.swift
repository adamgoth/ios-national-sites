//
//  SitesFilterTableViewController.swift
//  national-adventure-poc
//
//  Created by Adam Goth on 12/2/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import UIKit

class SitesFilterTableViewController: UITableViewController {
    
    var filteredSiteTypes: [DataService.SiteType]!

    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard
        if let previousFilter = defaults.object(forKey: "filteredSiteTypes") as? [String] {
            let mappedSites = previousFilter.map { return DataService.SiteType(rawValue: $0)! }
            filteredSiteTypes = mappedSites
        } else {
            filteredSiteTypes = DataService.allSiteTypes
        }
        
        title = "Site Types"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.allSiteTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let siteType = DataService.allSiteTypes[indexPath.row]
        
        cell.textLabel?.text = siteType.rawValue
        
        if filteredSiteTypes.contains(siteType) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let selectedSiteType = DataService.allSiteTypes[indexPath.row]
            
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                filteredSiteTypes.append(selectedSiteType)
            } else {
                cell.accessoryType = .none
                
                if let index = filteredSiteTypes.index(of: selectedSiteType) {
                    filteredSiteTypes.remove(at: index)
                }
            }
        }
        
        saveFilters()
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func saveFilters() {
        let defaults = UserDefaults.standard
        let mappedSites = filteredSiteTypes.map { return $0.rawValue }
        defaults.set(mappedSites, forKey: "filteredSiteTypes")
    }

}
