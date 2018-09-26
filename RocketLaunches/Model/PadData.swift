//
//  PadData.swift
//  RocketLaunches
//
//  Created by FAURE-VIDAL Laurene  on 25/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation

struct PadData : Decodable{
    var name: String
    var latitude: Double
    var longitude: Double
    var agencies: [AgencyData]?
}
