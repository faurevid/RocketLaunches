//
//  RocketLaunchesTableViewCell.swift
//  RocketLaunches
//
//  Created by FAURE-VIDAL Laurene  on 25/09/2018.
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
        
        var statusList = UserDefaults.standard.dictionary(forKey: "status")
        
        if (statusList != nil && statusList![String(launch.status)] != nil){
            status.text = statusList![String(launch.status)] as? String
        }
        
        launchWindow.text = launch.getWindow()
        favorite.isHidden = !launch.isLaunchFavorite()
        favorite.tintColor = UIColor.yellow
        cardView.layer.cornerRadius = 5
        
    }
}
