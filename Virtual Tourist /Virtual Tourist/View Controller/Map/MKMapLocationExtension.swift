//
//  MKMapLocationExtension.swift
//  Virtual Tourist
//
//  Created by Bushra on 21/01/2019.
//  Copyright © 2019 Bushra Alkhushiban. All rights reserved.
//

import Foundation
import MapKit

extension LocationViewController: MKMapViewDelegate {
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is MKPointAnnotation else { print("no mkpointannotaions"); return nil }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = false
            pinView!.rightCalloutAccessoryView = UIButton(type: .infoDark)
            pinView!.pinTintColor = UIColor.red
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("tapped on pin")
        if let alatitude = view.annotation?.coordinate.latitude , let alongitude = view.annotation?.coordinate.longitude {
            if let result = try? dataController.viewContext.fetch(fetchRequest) {
                for pin in result {
                    if pin.latitude == alatitude && pin.longitute == alongitude {
                        myPin = pin
                        print("inside mapview did select")
                        self.performSegue(withIdentifier: "photoAlbumSegue", sender: nil)
                    }
                    else {
                        print("returning")
                    }
                    
                }
            }
        }
    }
}

