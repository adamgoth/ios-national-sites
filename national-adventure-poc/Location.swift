//
//  Location.swift
//  national-adventure-poc
//
//  Created by Adam Goth on 12/2/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import UIKit
import MapKit

class Location: NSObject, MKAnnotation {
    public let title: String?
    public let latitude: CLLocationDegrees
    public let longitude: CLLocationDegrees
    public let coordinate: CLLocationCoordinate2D
    public let siteType: SiteType
    
    enum SiteType: String {
        case NationalPark = "National Parks"
        case NationalMonument = "National Monuments"
        case NationalPreserve = "National Preserves"
        case NationalHistoricalPark = "National Historical Parks"
        case NationalHistoricSite = "National Historic Sites"
    }
    
    init(title: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, siteType: SiteType) {
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.siteType = siteType
    }
}
