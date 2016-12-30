//
//  DataService.swift
//  national-adventure-poc
//
//  Created by Adam Goth on 12/1/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import Foundation
import MapKit

class DataService {
    
    public static var allLocations = [Location]()
    
    public static var allSiteTypes: [Location.SiteType] { return [
        .NationalPark,
        .NationalMonument,
        .NationalPreserve,
        .NationalHistoricalPark,
        .NationalHistoricSite,
        .Campsite,
        .Colorado14er
        ]
    }
    
    class func parseLocations() {
        for siteType in allSiteTypes {
            if let path = Bundle.main.path(forResource: siteType.rawValue, ofType: "csv") {
                do {
                    let csv = try CSV(contentsOfURL: path)
                    let rows = csv.rows
                    
                    for row in rows {
                        let name = row["Name"] ?? ""
                        let latitude = CLLocationDegrees(row["Latitude"]!)!
                        let longitude = CLLocationDegrees(row["Longitude"]!)!
                        let location = Location(title: name, latitude: latitude, longitude: longitude, siteType: siteType)
                        DataService.allLocations.append(location)
                    }
                } catch let error as NSError {
                    print(error.debugDescription)
                }
            }
        }
    }

}
