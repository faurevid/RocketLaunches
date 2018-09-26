//
//  DataManager.swift
//  RocketLaunches
//
//  Created by FAURE-VIDAL Laurene  on 25/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation

class DataManager{
    var launches: LaunchesData!
    var status: StatusData!
    
    func getNextLaunches(_ numberOfLaunched: Int) {
        let jsonUrlString = "https://launchlibrary.net/1.3/launch/next/\(numberOfLaunched)"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do{
                let launches = try JSONDecoder().decode(LaunchesData.self, from: data)
                print(launches)
                self.launches = launches
                
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
                self.status = status.types[0]
                
            }
            catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
            }.resume()
    }
    
}
