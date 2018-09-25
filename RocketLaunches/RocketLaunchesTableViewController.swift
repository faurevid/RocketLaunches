//
//  RocketLaunchesTableViewController.swift
//  RocketLaunches
//
//  Created by FAURE-VIDAL Laurene (Prestataire)  [IT-CE] on 25/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation
import UIKit

class RocketLaunchesTableViewController: UIViewController{
    var presenter : RocketLaunchesPresenterProtocol?
    
    @IBOutlet weak var launchesTableView: UITableView!
    
    //MARK: LifeCycle
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        presenter = RocketLaunchesTableViewPresenter(view: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

//MARK: RocketLaunchesViewControllerProtocol
extension RocketLaunchesTableViewController: RocketLaunchesViewControllerProtocol{
    func reloadData() {
        launchesTableView.reloadData()
    }
}

//MARK: TableView management
extension RocketLaunchesTableViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (presenter?.numberOfLaunches())!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "launchCell", for: indexPath) as? RocketLaunchesTableViewCell else{
            return UITableViewCell()
        }
        
        DispatchQueue.main.async {
        self.presenter?.willShow(cell: cell, indexPath: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}
