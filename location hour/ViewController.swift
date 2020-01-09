//
//  ViewController.swift
//  location hour
//
//  Created by MacStudent on 2020-01-09.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var adresLabel: UILabel!
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        latLabel.text = String(location.coordinate.latitude)
        longLabel.text = String(location.coordinate.longitude)
        speedLabel.text = String(location.speed)
        courseLabel.text = String(location.course)
        altitudeLabel.text = String(location.altitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
        if let error = error {
            print(error)
        } else {
            var address = ""
            if let placemark = placemarks?[0] {
                if placemark.subThoroughfare != nil {
                    address += placemark.subThoroughfare! + "\n"
                }
                if placemark.thoroughfare != nil {
                    address += placemark.thoroughfare! + "\n"
                }
                if placemark.subLocality != nil{
                    address += placemark.subLocality! + "\n"
                    
                }
                if placemark.administrativeArea != nil
                {
                    address += placemark.administrativeArea! + "\n"
                }
                if placemark.country != nil {
                    address += placemark.country!
                }
                self.adresLabel.text = address
                
            }
            }
        }
        
    }
}

