//
//  RocketLaunchesTableViewCell.swift
//  RocketLaunches
//
//  Created by FAURE-VIDAL Laurene (Prestataire)  [IT-CE] on 25/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation
import UIKit

class RocketLaunchesTableViewCell: UITableViewCell{
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var launchWindow: UILabel!
    @IBOutlet weak var favorite: UIImageView!
    
    func show(launch: LaunchData){
        self.backgroundColor = UIColor.clear
        name.text = launch.name
        if(launch.status  == 1){
            status.textColor = UIColor.green
        }
        else if(launch.status == 2){
            status.textColor = UIColor.red
        }
        //status.text = launch.statusData?.description
        launchWindow.text = launch.getWindow()
        favorite.isHidden = !launch.isFavourite
        cardView.layer.cornerRadius = 5
        
    }
}
