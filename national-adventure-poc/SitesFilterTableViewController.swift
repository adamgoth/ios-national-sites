//
//  SitesFilterTableViewController.swift
//  national-adventure-poc
//
//  Created by Adam Goth on 12/2/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import UIKit

class SitesFilterTableViewController: UITableViewController {
    
    var filteredSiteTypes: [Location.SiteType]!

    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard
        if let previousFilter = defaults.object(forKey: "filteredSiteTypes") as? [String] {
            let mappedSites = previousFilter.map { return Location.SiteType(rawValue: $0)! }
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
        
        cell.imageView?.image = UIImage(named: siteType.rawValue)
        
        //resize image
        let itemSize = CGSize(width: 20.0, height: 20.0)
        UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.main.scale)
        let imageRect = CGRect(x: 0, y: 0, width: itemSize.width, height: itemSize.height)
        cell.imageView!.image?.draw(in: imageRect)
        cell.imageView!.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        cell.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        
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
