//
//  RocketLaunchesTableViewPresenter.swift
//  RocketLaunches
//
//  Created by FAURE-VIDAL Laurene (Prestataire)  [IT-CE] on 25/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation

class RocketLaunchesTableViewPresenter {
    weak var view: RocketLaunchesViewControllerProtocol?
    var launches : LaunchesData?
    
    init(view: RocketLaunchesViewControllerProtocol?){
        self.view = view
        getNextLaunches(50)
    }
    
    func getNextLaunches(_ numberOfLaunched: Int) {
        let jsonUrlString = "https://launchlibrary.net/1.3/launch/next/\(numberOfLaunched)"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do{
                let launches = try JSONDecoder().decode(LaunchesData.self, from: data)
                self.launches = launches
                DispatchQueue.main.async {
                    self.view?.reloadData()
                }
                
            }
            catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
            }.resume()
    }
}
extension RocketLaunchesTableViewPresenter: RocketLaunchesPresenterProtocol{
    func numberOfLaunches() -> Int {
        guard let launches = launches else {
            return 0
        }
        return launches.launches.count
    }
    
    func willShow(cell: RocketLaunchesTableViewCell, indexPath: IndexPath) {
        guard let launch = launches?.launches[indexPath.row] else {
            return
        }
            cell.show(launch: launch)
    }
}

