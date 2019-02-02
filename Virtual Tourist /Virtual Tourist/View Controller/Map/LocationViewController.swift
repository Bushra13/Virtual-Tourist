//
//  LocationViewController.swift
//  Virtual Tourist
//
//  Created by Bushra on 21/01/2019.
//  Copyright © 2019 Bushra Alkhushiban. All rights reserved.
//

import UIKit
import MapKit
import CoreData


class LocationViewController: UIViewController {

    var dataController: DataController!
    var fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest()
    
    @IBOutlet weak var mapView: MKMapView!
    
    var myPin : Pin!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupFetchedResultsController()
        // check long press and do an action through selector
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(LocationViewController.handleLongPress(_:)))
        longPressRecogniser.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longPressRecogniser)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchedResultsController()
    }
    
    
    //Handling Long Press
    
    @objc func handleLongPress(_ gestureRecognizer : UIGestureRecognizer){
        if gestureRecognizer.state != .began { return }
        let touchPoint = gestureRecognizer.location(in: mapView)
        let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        newAnnotation(Coordinate: touchMapCoordinate)
    }
    
    //Coordinate Location and Make New One
    
    func newAnnotation(Coordinate: CLLocationCoordinate2D ){
        let annotation = MKPointAnnotation()
        annotation.coordinate = Coordinate
        persistNewPin(location: Coordinate)
        mapView.addAnnotation(annotation)
    }
    
    //To save Pin
    func persistNewPin(location: CLLocationCoordinate2D){
        let newPin = Pin(context: dataController.viewContext)
        newPin.latitude = location.latitude
        newPin.longitute = location.longitude
        do{
            try dataController.viewContext.save()
            print("saved view context")
            myPin = newPin
        } catch{
            print("Persist New Pin Error")
            debugPrint()
        }
    }
    
    //Setup fetched result controller
    func setupFetchedResultsController() {
        if let result = try? dataController.viewContext.fetch(fetchRequest) {
            for pin in result {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(pin.latitude), longitude: CLLocationDegrees(pin.longitute))
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    
    // Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoAlbumSegue"{
            let vc = segue.destination as! PhotosViewController
            vc.pin = myPin
        }
    }
    
}
