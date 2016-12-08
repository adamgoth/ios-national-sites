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
        
        DataService.parseLocations()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(filterSiteTypes))
        
        createAnnotations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshAnnotations()
    }
    
    func filterSiteTypes() {
        performSegue(withIdentifier: "showSitesFilter", sender: self)
    }
    
    func createAnnotations() {
        var selectedSiteTypes: [Location.SiteType]!
        let defaults = UserDefaults.standard
        if let previousFilter = defaults.object(forKey: "filteredSiteTypes") as? [String] {
            let mappedSites = previousFilter.map { return Location.SiteType(rawValue: $0)! }
            selectedSiteTypes = mappedSites
        } else {
            selectedSiteTypes = DataService.allSiteTypes
        }
        
        if selectedSiteTypes.contains(.NationalPark) {
            for park in DataService.allLocations.filter({ return $0.siteType == .NationalPark }) {
                let anno = park
                mapView.addAnnotation(anno)
            }
        }
        if selectedSiteTypes.contains(.NationalMonument) {
            for park in DataService.allLocations.filter({ return $0.siteType == .NationalMonument }) {
                let anno = park
                mapView.addAnnotation(anno)
            }
        }
        if selectedSiteTypes.contains(.NationalPreserve) {
            for park in DataService.allLocations.filter({ return $0.siteType == .NationalPreserve }) {
                let anno = park
                mapView.addAnnotation(anno)
            }
        }
        if selectedSiteTypes.contains(.NationalHistoricalPark) {
            for park in DataService.allLocations.filter({ return $0.siteType == .NationalHistoricalPark }) {
                let anno = park
                mapView.addAnnotation(anno)
            }
        }
        
    }
    
    func refreshAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
        createAnnotations()
    }

}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"

        var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        let annotation = annotation as! Location
        
        if view == nil {
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view?.canShowCallout = true
        } else {
            view?.annotation = annotation
        }
        
        switch annotation.siteType {
        case .NationalPark:
            view?.image = UIImage(named: "tree")
        case .NationalMonument:
            view?.image = UIImage(named: "monument")
        case .NationalPreserve:
            view?.image = UIImage(named: "eagle")
        case .NationalHistoricalPark:
            view?.image = UIImage(named: "bench")
        }
        view?.frame.size = CGSize(width: 20.0, height: 20.0)
        
        return view
    }
}

