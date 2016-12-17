//
//  TableViewController.swift
//  national-adventure-poc
//
//  Created by Adam Goth on 12/1/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import UIKit
import SafariServices

class TableViewController: UITableViewController {
    
    var selectedSiteTypes: [Location.SiteType]!
    var sitesList = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Outdoor Explorer"
        
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
        cell.imageView?.image = UIImage(named: sitesList[indexPath.row].siteType.rawValue)
        cell.accessoryType = .disclosureIndicator
        
        //resize image
        let itemSize = CGSize(width: 20.0, height: 20.0)
        UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.main.scale)
        let imageRect = CGRect(x: 0, y: 0, width: itemSize.width, height: itemSize.height)
        cell.imageView!.image?.draw(in: imageRect)
        cell.imageView!.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        cell.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showGoogleResults(site: sitesList[indexPath.row].title!)
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
    
    func showGoogleResults(site: String) {
        let formattedURL = site.replacingOccurrences(of: " ", with: "_")
        if let url = URL(string: "https://www.google.com/#q=\(formattedURL)") {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        } else {
            print("An error occured while formatting the URL")
        }
    }
    

}
