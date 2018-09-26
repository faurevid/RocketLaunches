//
//  LaunchData.swift
//  RocketLaunches
//
//  Created by FAURE-VIDAL Laurene  on 25/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation

struct LaunchesData: Decodable{
    let launches: [LaunchData]

}

class LaunchData : Decodable{
    let id : Int
    let name: String
    let windowstart: String
    let windowend: String
    let status: Int
    let rocket: RocketData
    let location: LocationData
    var statusData: StatusData?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case windowstart
        case windowend
        case status
        case rocket
        case location
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        windowstart = try values.decode(String.self, forKey: .windowstart)
        windowend = try values.decode(String.self, forKey: .windowend)
        status = try values.decode(Int.self, forKey: .status)
        rocket = try values.decode(RocketData.self, forKey: .rocket)
        location = try values.decode(LocationData.self, forKey: .location)
        statusData = nil
    }
    
    func getWindow() -> String{
        return windowstart + " - " + windowend
    }
    
    func isLaunchFavorite() -> Bool{
        guard let favoriteList = UserDefaults.standard.array(forKey: "favorites") else{
            return false
        }
        if(favoriteList.contains(where: {$0 as! Int == id})){
            return true
        }
        return false
    }
}

struct StatusType: Decodable{
    let types: [StatusData]
}

struct StatusData: Decodable {
    let id: Int
    let name: String
    let description: String
}

struct LocationData:Decodable {
    let pads: [PadData]
}

