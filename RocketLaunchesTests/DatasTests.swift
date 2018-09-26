//
//  DatasTests.swift
//  RocketLaunchesTests
//
//  Created by FAURE-VIDAL Laurene  on 25/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import XCTest
@testable import RocketLaunches

class DatasTests: XCTestCase {
    var presenter: RocketLaunchesTableViewPresenter!
    var firstView: RocketLaunchesTableViewController!
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: RocketLaunchesTableViewController = storyboard.instantiateViewController(withIdentifier: "RocketLaunchesTableViewController") as! RocketLaunchesTableViewController
        firstView = vc
        _ = firstView.view
        presenter = RocketLaunchesTableViewPresenter(view: firstView)
    }
    
    override func tearDown() {
        super.tearDown()
        presenter = nil
        firstView = nil
    }
    
    func testOneLaunch() {
        presenter.getNextLaunches(50)
        sleep(10)
        XCTAssertEqual(presenter.launches?.launches.count, 50)
    }
    
    func testStatusOne(){
        presenter.getStatus(1)
        sleep(5)
        let statusList = UserDefaults.standard.dictionary(forKey: "status")
        XCTAssertEqual(statusList!["1"] as! String, "Launch is GO")
    }
    
    
}
