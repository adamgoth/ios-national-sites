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
            let anno = park
            mapView.addAnnotation(anno)
        }
        for park in DataService.allNationalMonuments {
            let anno = park
            mapView.addAnnotation(anno)
        }
    }

}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"

        var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if view == nil {
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view?.canShowCallout = true
        } else {
            view?.annotation = annotation
        }
        
        switch annotation {
        case is NationalPark:
            view?.image = UIImage(named: "tree")
        case is NationalMonument:
            view?.image = UIImage(named: "monument")
        default:
            view?.image = nil
        }
        view?.frame.size = CGSize(width: 20.0, height: 20.0)
        
        return view
    }
}

