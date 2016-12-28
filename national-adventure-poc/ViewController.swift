//
//  ViewController.swift
//  national-adventure-poc
//
//  Created by Adam Goth on 12/1/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var selectedSiteTypes: [Location.SiteType]?
    
    let locationManager = CLLocationManager()
    var userLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationAuthStatus()
        
        DataService.parseLocations()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(filterSiteTypes))
        
        createAnnotations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //only refresh annotations if filter changed
        let defaults = UserDefaults.standard
        if let previousFilter = defaults.object(forKey: "filteredSiteTypes") as? [String] {
            let mappedSites = previousFilter.map { return Location.SiteType(rawValue: $0)! }
            if selectedSiteTypes! != mappedSites {
                refreshAnnotations()
            }
        }
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func centerMapOnLocation() {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation!.coordinate, 800000.0, 800000.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func filterSiteTypes() {
        performSegue(withIdentifier: "showSitesFilter", sender: self)
    }
    
    func createAnnotations() {
        let defaults = UserDefaults.standard
        if let previousFilter = defaults.object(forKey: "filteredSiteTypes") as? [String] {
            let mappedSites = previousFilter.map { return Location.SiteType(rawValue: $0)! }
            selectedSiteTypes = mappedSites
        } else {
            selectedSiteTypes = DataService.allSiteTypes
        }
        
        if let siteTypes = selectedSiteTypes {
            for siteType in siteTypes {
                for park in DataService.allLocations.filter({ return $0.siteType == siteType }) {
                    let anno = park
                    mapView.addAnnotation(anno)
                }
            }
        }
    }
    
    func refreshAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
        createAnnotations()
    }
    
    func showGoogleResults(site: String) {
        let formattedURL = site.replacingOccurrences(of: " ", with: "%20")
        if let url = URL(string: "https://www.google.com/#q=\(formattedURL)") {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        } else {
            print("An error occured while formatting the URL")
        }
    }

}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Location {
            let identifier = "pin"
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view?.canShowCallout = true
            } else {
                view?.annotation = annotation
            }
            
            view?.image = UIImage(named: annotation.siteType.rawValue)
            
            view?.frame.size = CGSize(width: 20.0, height: 20.0)
            
            view?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            return view
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let annotation = view.annotation {
                showGoogleResults(site: annotation.title!!)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if self.userLocation == nil {
            self.userLocation = userLocation.location
            centerMapOnLocation()
            print("\(userLocation.location)")
        }
    }
}

