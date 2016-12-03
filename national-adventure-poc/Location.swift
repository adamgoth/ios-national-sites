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
    public let pinColor: UIColor
    
    init(title: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, pinColor: UIColor) {
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.pinColor = pinColor
    }
}
