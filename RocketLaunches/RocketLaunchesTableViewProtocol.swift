//
//  RocketLaunchesTableViewProtocol.swift
//  RocketLaunches
//
//  Created by FAURE-VIDAL Laurene  on 25/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation
import UIKit


protocol RocketLaunchesViewControllerProtocol: class {
    func reloadData()
    func startLoader()
    func stopLoader()
    func displayNetworkError()
}

protocol RocketLaunchesPresenterProtocol: class {
     func numberOfLaunches(inSection: Int) -> Int
    func willShow(cell: RocketLaunchesTableViewCell, indexPath: IndexPath )
    func getSelectedLaunch(at: IndexPath) -> LaunchData?
    func filterArrays()
    func hasFavorite() -> Bool
}
