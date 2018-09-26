//
//  RocketData.swift
//  RocketLaunches
//
//  Created by FAURE-VIDAL Laurene  on 25/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation
import UIKit

class RocketData : Decodable{
    var name: String
    var imageURL: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case imageURL
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        imageURL = try values.decode(String.self, forKey: .imageURL)
    }
}
