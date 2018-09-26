//
//  RocketLaunchesTableViewProtocol.swift
//  RocketLaunches
//
//  Created by FAURE-VIDAL Laurene (Prestataire)  [IT-CE] on 25/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation
import UIKit


protocol RocketLaunchesViewControllerProtocol: class {
    func reloadData()
    func startLoader()
    func stopLoader()
}

protocol RocketLaunchesPresenterProtocol: class {
    func numberOfLaunches() -> Int
    func willShow(cell: RocketLaunchesTableViewCell, indexPath: IndexPath )
    func getSelectedLaunch(at: IndexPath) -> LaunchData?
}
