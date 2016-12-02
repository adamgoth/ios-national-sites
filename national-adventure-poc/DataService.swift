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
    public static var allNationalParks = [NationalPark]()
    public static var allNationalMonuments = [NationalMonument]()
    
    class func parseNationalParks() {
        if let path = Bundle.main.path(forResource: "NationalParks", ofType: "csv") {
            do {
                let csv = try CSV(contentsOfURL: path)
                let rows = csv.rows
                
                for row in rows {
                    let name = row["Name"] ?? ""
                    let latitude = CLLocationDegrees(row["Latitude"]!)!
                    let longitude = CLLocationDegrees(row["Longitude"]!)!
                    
                    let park = NationalPark(name: name, latitude: latitude, longitude: longitude)
                    
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
                    
                    let monument = NationalMonument(name: name, latitude: latitude, longitude: longitude)
                    
                    DataService.allNationalMonuments.append(monument)
                }
            } catch let error as NSError {
                print(error.debugDescription)
            }
        }
    }
}
