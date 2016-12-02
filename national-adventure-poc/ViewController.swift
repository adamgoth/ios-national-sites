//
//  ViewController.swift
//  national-adventure-poc
//
//  Created by Adam Goth on 12/1/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        createAnnotations()
    }
    
    func createAnnotations() {
        for park in DataService.allNationalParks {
            let location = CLLocation(latitude: park.latitude, longitude: park.longitude)
            let anno = MKPointAnnotation()
            anno.title = park.name
            anno.coordinate = location.coordinate
            mapView.addAnnotation(anno)
        }
        for park in DataService.allNationalMonuments {
            let location = CLLocation(latitude: park.latitude, longitude: park.longitude)
            let anno = MKPointAnnotation()
            anno.title = park.name
            anno.coordinate = location.coordinate
            mapView.addAnnotation(anno)
        }
    }

}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            view?.canShowCallout = true
        } else {
            view?.annotation = annotation
        }
        
        return view
    }
}

