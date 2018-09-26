//
//  LaunchDetailViewController.swift
//  RocketLaunches
//
//  Created by FAURE-VIDAL Laurene (Prestataire)  [IT-CE] on 26/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class LaunchDetailViewController: UIViewController {
    @IBOutlet weak var rocketImage: UIImageView!
    @IBOutlet weak var rocketName: UILabel!
    @IBOutlet weak var agencies: UILabel!
    @IBOutlet weak var padMap: MKMapView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    var presenter: LaunchDetailPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.willLoad()
       
    }
    
    @IBAction func makeLaunchFavorite(_ sender: Any) {
        favoriteBtn.tintColor = presenter.saveFavorite() ?UIColor.yellow : UIColor.darkGray
       
    }
}

extension LaunchDetailViewController: LaunchDetailViewControllerProtocol{
    func loadWith(launch: LaunchData?){
        guard let launch = launch else {
            return
        }
        
        self.title = launch.name
        rocketName.text = launch.rocket.name
        
        favoriteBtn.tintColor = launch.isLaunchFavorite() ?UIColor.yellow : UIColor.darkGray
        
        presenter.zoomOnPadLocation(onMap: padMap)
        presenter.displayImage(onView: rocketImage)
        cardView.layer.cornerRadius = 5
        
        var agenciesText = "Agencies "
        guard let agenciesList = launch.location.pads[0].agencies else{
            agencies.text = "No agency found"
            return
        }
        for i in 0...agenciesList.count-1{
            agenciesText += "\n" + agenciesList[i].name + " (" + agenciesList[i].countryCode + ")"
        }
        agencies.text = agenciesText
    }
    
    //MARK: Loader Management
    func startLoader(){
        if let loader = self.loader{
            loader.startAnimating()
        }
    }
    func stopLoader(){
        if let loader = self.loader{
            loader.stopAnimating()
        }
    }
}

