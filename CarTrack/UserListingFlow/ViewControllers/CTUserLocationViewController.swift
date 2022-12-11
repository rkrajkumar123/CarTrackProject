//
//  CTUserLocationViewController.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 10/12/22.
//

import UIKit
import MapKit

//MARK: UserLocationViewController used for showing Map and location
class CTUserLocationViewController: CTBaseViewController {
    
    @IBOutlet weak var userMap: MKMapView!
    lazy var userLocationViewModel = CTUserLocationViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setMapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNavigationBar(with: Constants.userLocation)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hideNavigationBar()
    }
    
    //MARK: Setting of MapView
    private func setMapView(){
        userMap.register(CTUserAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        if let userLocationModel = userLocationViewModel.userLocationModel{
            debugPrint("Lat:\(userLocationModel.latitude.doubleValue)")
            debugPrint("Lat:\(userLocationModel.longitude.doubleValue)")
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: userLocationModel.latitude.doubleValue, longitude: userLocationModel.longitude.doubleValue)
            annotation.title = userLocationModel.name
            annotation.subtitle =  userLocationModel.address
            Utils.delay(2) { [weak self] in
                let coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocationModel.latitude.doubleValue, longitude: userLocationModel.longitude.doubleValue), latitudinalMeters: userLocationModel.radius, longitudinalMeters: userLocationModel.radius)
                self?.userMap.setRegion(coordinateRegion, animated: true)
            }
            self.userMap.addAnnotation(annotation)
        }
    }
    
    //MARK: Set user origin on map
    @IBAction func setUserOrigin(_ sender: UIButton) {
        if let userLocationModel = userLocationViewModel.userLocationModel{
            let coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocationModel.latitude.doubleValue, longitude: userLocationModel.longitude.doubleValue), latitudinalMeters: userLocationModel.radius, longitudinalMeters: userLocationModel.radius)
            userMap.setRegion(coordinateRegion, animated: true)
        }
    }
}
