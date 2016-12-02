//
//  Location.swift
//  national-adventure-poc
//
//  Created by Adam Goth on 12/1/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import Foundation
import MapKit

class Location {
    public let name: String
    public let latitude: CLLocationDegrees
    public let longitude: CLLocationDegrees
    
    init(name: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
