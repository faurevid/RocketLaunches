//
//  DatasTests.swift
//  RocketLaunchesTests
//
//  Created by FAURE-VIDAL Laurene (Prestataire)  [IT-CE] on 25/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import XCTest
@testable import RocketLaunches

class DatasTests: XCTestCase {
    var dataManager: DataManager!
    override func setUp() {
        super.setUp()
        dataManager = DataManager()
    }
    
    override func tearDown() {
        super.tearDown()
        dataManager = nil
    }
    
    func testOneLaunch() {
        dataManager.getNextLaunches(1)
        sleep(5)
        XCTAssertEqual(dataManager.launches.launches.count, 1)
    }
    
    func testStatusOne(){
        dataManager.getStatus(1)
        sleep(5)
        XCTAssertEqual(dataManager.status.description, "Launch is GO")
    }
    
    
}
