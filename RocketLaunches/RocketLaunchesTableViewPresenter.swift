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
    var allLaunches: LaunchesData?
    var launches : LaunchesData?
    var favoriteLaunches: LaunchesData?
    
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
                self.allLaunches = launches
                self.filterArrays()
                
                let statusList = NSSet(array: launches.launches.compactMap({$0.status}))
                
                var statusListDefault = UserDefaults.standard.dictionary(forKey: "status")
                
                for i in 0...statusList.count-1  {
                    if statusListDefault == nil ||
                        statusListDefault![String(statusList.allObjects[i] as! Int)] != nil {
                    self.getStatus(statusList.allObjects[i] as? Int ?? 1)
                    }
                }
                
                DispatchQueue.main.async {
                    self.view?.stopLoader()
                    self.view?.reloadData()
                }
                
            }
            catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
            }.resume()
    }
    
    func getStatus(_ statusId: Int) {
        let jsonUrlString = "https://launchlibrary.net/1.3/launchstatus/\(statusId)"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do{
                let status = try JSONDecoder().decode(StatusType.self, from: data)
                print(status)
                self.save(status: status.types[0])
                DispatchQueue.main.sync {
                    self.view?.stopLoader()
                    self.view?.reloadData()
                }
            }
            catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
            }.resume()
    }
    
    func save(status: StatusData){
        guard var statusList = UserDefaults.standard.dictionary(forKey: "status")else{
            UserDefaults.standard.setValue([String(status.id): status.description], forKey: "status")
            UserDefaults.standard.synchronize()
            print(UserDefaults.standard.dictionaryRepresentation())
            return
        }
        statusList[String(status.id)] = status.description
        UserDefaults.standard.setValue(statusList, forKey: "status")
        UserDefaults.standard.synchronize()
        print(UserDefaults.standard.dictionaryRepresentation())
    }
    
    func filterArrays(){
        guard let launches = allLaunches else {
            return
        }
        self.favoriteLaunches = LaunchesData(launches: launches.launches.filter({$0.isLaunchFavorite() == true}))
        self.launches = LaunchesData(launches: launches.launches.filter({$0.isLaunchFavorite() == false}))
    }
}
extension RocketLaunchesTableViewPresenter: RocketLaunchesPresenterProtocol{
    func numberOfLaunches(inSection: Int) -> Int {
        
        if(inSection == 0){
            guard let favoriteLaunches = favoriteLaunches else {
              return 0
            }
            return hasFavorite() ? favoriteLaunches.launches.count : launches!.launches.count
        }else{
            guard let launches = launches else {
                return 0
            }
            return launches.launches.count
        }
    }
    
    func hasFavorite() -> Bool{
        guard let favoriteLaunches = favoriteLaunches else {
            return false
        }
        return favoriteLaunches.launches.count > 0
    }
    
    func willShow(cell: RocketLaunchesTableViewCell, indexPath: IndexPath) {
        if(indexPath.section == 0 && self.hasFavorite()) {
            guard let launch = favoriteLaunches?.launches[indexPath.row] else {
                return
            }
            cell.show(launch: launch)
        }else{
            guard let launch = launches?.launches[indexPath.row] else {
                return
            }
            cell.show(launch: launch)
        }
    }
    
    func getSelectedLaunch(at: IndexPath) -> LaunchData?{
        if(at.section == 0 && (favoriteLaunches?.launches.count)! > 0){
             return favoriteLaunches?.launches[at.row]
        }else{
            return launches?.launches[at.row]
        }
    }
}

