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
    var selectedLaunch : LaunchData?
    @IBOutlet weak var launchesTableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    //MARK: LifeCycle
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        presenter = RocketLaunchesTableViewPresenter(view: self)
        selectedLaunch = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Upcoming Launches"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.filterArrays()
        reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openDetail", let destination = segue.destination as? LaunchDetailViewController {
            let detailPresenter = LaunchDetailPresenter(launch: selectedLaunch!, view: destination) as LaunchDetailPresenterProtocol
            destination.presenter = detailPresenter
            
            }
        
    }
}

//MARK: RocketLaunchesViewControllerProtocol
extension RocketLaunchesTableViewController: RocketLaunchesViewControllerProtocol{
    @objc func reloadData() {
        launchesTableView.reloadData()
    }
    //MARK: Loader Management
    func startLoader(){
        if let loader = self.loader{
            loader.startAnimating()
        }
    }
    func stopLoader(){
        if let loader = self.loader{
            loader.stopAnimating()
        }
    }
}

//MARK: TableView management
extension RocketLaunchesTableViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (presenter?.hasFavorite())! ? 2 : 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (presenter?.numberOfLaunches(inSection: section))!
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLaunch = presenter?.getSelectedLaunch(at: indexPath)
        performSegue(withIdentifier: "openDetail", sender: self)
    }
    
    func titleForHeaderInSection(section: Int) -> String? {
        if(numberOfSections(in: launchesTableView) == 1 ){
            return ""
        }
        return section == 0 ? "Favorites" : "Upcoming"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        contentView.backgroundColor = UIColor.black
        let titleLabel = UILabel(frame: contentView.frame)
        titleLabel.text = titleForHeaderInSection(section: section)
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        contentView.addSubview(titleLabel)
        return contentView
    }
    
}
