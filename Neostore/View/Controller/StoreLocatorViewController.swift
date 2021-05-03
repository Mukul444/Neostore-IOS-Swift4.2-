//
//  StoreLocatorViewController.swift
//  Neostore
//
//  Created by webwerks1 on 05/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit
import MapKit

class StoreLocatorViewController: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var storeLocationMap: MKMapView!
    
    //MARK: - Variables
    let storeCordinates = CLLocationCoordinate2DMake(41.8832301, -87.6278121)
    let stores = FurnitureStore().store
    let storeArray = [STRING.luna,
                      STRING.carlo,
                      STRING.fabia,
                      STRING.leLo,
                      STRING.neoLo,
                      STRING.hP,
                      STRING.futureFurnitureCentre,
                      STRING.iKEA]
    let storeLocationsArray = [STRING.lunaAddress,
                               STRING.carloAddress,
                               STRING.fabia,
                               STRING.leLoAddress,
                               STRING.neoLoAddress,
                               STRING.hPAddress,
                               STRING.futureFurnitureCentreAddress,
                               STRING.iKEAAddress]
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        tableViewSetup()
    }
    
    func viewSetup(){
        storeLocationMap.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        resetRegion()
    }
    
    func resetRegion() {
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let rgn = MKCoordinateRegion(center: storeCordinates, span: span)
        storeLocationMap.setRegion(rgn, animated: true)
        let pin = MKPointAnnotation()
        pin.coordinate = storeCordinates
        //pin.title = "0,0 Street Numbers"
        storeLocationMap.addAnnotation(pin)
        storeLocationMap.addAnnotations(stores)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func tableViewSetup()
    {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK:- IBActions
    @IBAction func didTapBackBtn(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        
    }
}

//MARK:- TableView Extension
extension StoreLocatorViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: STRING.goToStoreLocator, for: indexPath) as! StoreLocatorTableViewCell
        cell.locationNameLabel.text = storeArray[indexPath.row]
        cell.locationDiscriptionLabel.text = storeLocationsArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83.5    }
    
}

//MARK:- MKMapViewDelegate Extension
extension  StoreLocatorViewController:  MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view: MKPinAnnotationView
        guard let annotation = annotation as? StoreLocatorViewModel else {
            return nil
        }
        if let dequeuedview = storeLocationMap.dequeueReusableAnnotationView(withIdentifier: annotation.identifier) as? MKPinAnnotationView {
            view = dequeuedview
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier)
        }
        view.isEnabled = true
        view.canShowCallout = true
        return view
    }
    
}



    // MARK:- StoreLocatorViewModel
class StoreLocatorViewModel: NSObject, MKAnnotation{
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var identifier = STRING.storeLocator
    
    init(name: String, lat: CLLocationDegrees, long: CLLocationDegrees) {
        title = name
        coordinate = CLLocationCoordinate2DMake(lat, long)
    }
}

    // MARK:- FurnitureStore
class FurnitureStore: NSObject {
    var store = [StoreLocatorViewModel]()
    override init(){
        store += [StoreLocatorViewModel(name:STRING.luna,lat:41.84937922,long:-87.6410584  )]
        store += [StoreLocatorViewModel(name:STRING.carlo,lat:41.90146341,long: -87.62848137 )]
        store += [StoreLocatorViewModel(name:STRING.fabia,lat:41.85110748,long: -87.61286663 )]
        store += [StoreLocatorViewModel(name:STRING.leLo,lat:41.89224916,long:-87.60951805  )]
        store += [StoreLocatorViewModel(name:STRING.neoLo,lat:42.00302015,long:-87.81630768  )]
        store += [StoreLocatorViewModel(name:STRING.hP,lat:41.79915575,long:-87.59028088)]
        store += [StoreLocatorViewModel(name:STRING.futureFurnitureCentre,lat:41.85776469,long:-87.66138509)]
        store += [StoreLocatorViewModel(name:STRING.iKEA,lat:41.95296188,long:-87.77541371)]
    }
}


