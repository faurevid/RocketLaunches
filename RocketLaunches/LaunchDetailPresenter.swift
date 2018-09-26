//
//  LaunchDetailPresenter.swift
//  RocketLaunches
//
//  Created by FAURE-VIDAL Laurene  on 26/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation
import MapKit


class LaunchDetailPresenter {
    
    var launch: LaunchData?
    weak var view: LaunchDetailViewControllerProtocol?
    
    var locationManager:CLLocationManager!

    
    init(launch: LaunchData, view: LaunchDetailViewControllerProtocol){
        self.launch = launch
        self.view = view
    }
    
    
}

extension LaunchDetailPresenter: LaunchDetailPresenterProtocol{
    func willLoad(){
        view?.loadWith(launch: launch)
    }
    
    func zoomOnPadLocation(onMap: MKMapView){
        guard let pad = launch?.location.pads[0] else {
            return
        }
        let center = CLLocationCoordinate2D(latitude: pad.latitude, longitude: pad.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        onMap.setRegion(region, animated: true)
        
        // Drop a pin at pad's location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(pad.latitude, pad.longitude);
        myAnnotation.title = pad.name
        onMap.addAnnotation(myAnnotation)
    }
    
    func displayImage(onView: UIImageView){
        guard let url = NSURL(string:(launch?.rocket.imageURL)!) else {
            return
        }
        DispatchQueue.main.async() {
        if let data = try? Data(contentsOf: url as URL) {
            onView.image = UIImage(data: data)
            self.view?.stopLoader()
        }
        }
    }
    
    func saveFavorite() -> Bool {
        guard let launch = launch else {
            return false
        }
        if var favoriteList = UserDefaults.standard.array(forKey: "favorites"){
            if launch.isLaunchFavorite(){
                let index = favoriteList.index(where: {$0 as! Int == launch.id})!
                favoriteList.remove(at:index)
                UserDefaults.standard.setValue(favoriteList, forKey: "favorites")
                return false
            }
            else{
                favoriteList.append(launch.id)
              UserDefaults.standard.setValue(favoriteList, forKey: "favorites")
                return true
            }
        }
        else{
            UserDefaults.standard.setValue([launch.id], forKey: "favorites")
             return true
        }
    }
}
