//
//  LaunchDetailProtocol.swift
//  RocketLaunches
//
//  Created by FAURE-VIDAL Laurene (Prestataire)  [IT-CE] on 26/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation
import MapKit

protocol LaunchDetailViewControllerProtocol: class {
    func loadWith(launch: LaunchData?)
    func startLoader()
    func stopLoader()
}

protocol LaunchDetailPresenterProtocol: class {
     func willLoad()
    func zoomOnPadLocation(onMap: MKMapView)
    func displayImage(onView: UIImageView)
}
