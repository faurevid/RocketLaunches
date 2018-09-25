//
//  RocketData.swift
//  RocketLaunches
//
//  Created by FAURE-VIDAL Laurene (Prestataire)  [IT-CE] on 25/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation
import UIKit

class RocketData : Decodable{
    var name: String
    //var image: UIImage
    
    private enum CodingKeys: String, CodingKey {
        case name
        //case image
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        //image = try values.decode(UIImage.self, forKey: .name)
    }
}
