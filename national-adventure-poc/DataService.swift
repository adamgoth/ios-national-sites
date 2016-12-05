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

    public enum SiteType: String {
        case NationalPark = "National Parks"
        case NationalMonument = "National Monuments"
        case NationalPreserve = "National Preserves"
    }
    public static var allSiteTypes: [SiteType] { return [
        .NationalPark,
        .NationalMonument,
        .NationalPreserve
        ]
    }
    public static var allNationalParks = [NationalPark]()
    public static var allNationalMonuments = [NationalMonument]()
    public static var allNationalPreserves = [NationalPreserve]()
    
    class func parseNationalParks() {
        if let path = Bundle.main.path(forResource: "NationalParks", ofType: "csv") {
            do {
                let csv = try CSV(contentsOfURL: path)
                let rows = csv.rows
                
                for row in rows {
                    let name = row["Name"] ?? ""
                    let latitude = CLLocationDegrees(row["Latitude"]!)!
                    let longitude = CLLocationDegrees(row["Longitude"]!)!
                    
                    let park = NationalPark(title: name, latitude: latitude, longitude: longitude)
                    
                    DataService.allNationalParks.append(park)
                }
            } catch let error as NSError {
                print(error.debugDescription)
            }
        }
    }
    
    class func parseNationalMonuments() {
        if let path = Bundle.main.path(forResource: "NationalMonuments", ofType: "csv") {
            do {
                let csv = try CSV(contentsOfURL: path)
                let rows = csv.rows
                
                for row in rows {
                    let name = row["Name"] ?? ""
                    let latitude = CLLocationDegrees(row["Latitude"]!)!
                    let longitude = CLLocationDegrees(row["Longitude"]!)!
                    
                    let monument = NationalMonument(title: name, latitude: latitude, longitude: longitude)
                    
                    DataService.allNationalMonuments.append(monument)
                }
            } catch let error as NSError {
                print(error.debugDescription)
            }
        }
    }
    
    class func parseNationalPreserves() {
        if let path = Bundle.main.path(forResource: "NationalPreserves", ofType: "csv") {
            do {
                let csv = try CSV(contentsOfURL: path)
                let rows = csv.rows
                
                for row in rows {
                    let name = row["Name"] ?? ""
                    let latitude = CLLocationDegrees(row["Latitude"]!)!
                    let longitude = CLLocationDegrees(row["Longitude"]!)!
                    
                    let preserve = NationalPreserve(title: name, latitude: latitude, longitude: longitude)
                    
                    DataService.allNationalPreserves.append(preserve)
                }
            } catch let error as NSError {
                print(error.debugDescription)
            }
        }
    }
}
