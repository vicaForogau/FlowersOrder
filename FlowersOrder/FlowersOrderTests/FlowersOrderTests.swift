//
//  FlowersOrderTests.swift
//  FlowersOrderTests
//
//  Created by Vica Forogau on 28/12/2017.
//  Copyright © 2017 Vica Forogau. All rights reserved.
//

import XCTest
@testable import FlowersOrder

class FlowersOrderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // Confirm that the order initializer returns a Order object when passed valid parameters.
    func testMealInitializationSucceeds() {
        
        let orderOK = Order.init(data: ["id": 26, "description": "Blue Roses",
            "price": 178,
            "deliver_to": "Oana",
            "address" : "Horia 3, Cluj Napoca",
            "deliverd" : 1,
            "imgUrl" : "https://i.pinimg.com/564x/23/03/2c/23032cbd26824f67862a71082384f83f.jpg"
        ])
        XCTAssertNotNil(orderOK)
        
    }
    
    // Confirm that the Order initialier returns nil when data is missing.
    func testMealInitializationFails() {
        
        // Missing id
        let orderWithoutId = Order.init(data: ["description": "Blue Roses",
             "price": 178,
             "deliver_to": "Oana",
             "address" : "Horia 3, Cluj Napoca",
             "deliverd" : 1,
             "imgUrl" : "https://i.pinimg.com/564x/23/03/2c/23032cbd26824f67862a71082384f83f.jpg"
            ])
        XCTAssertNil(orderWithoutId)
        
        // Missing description
        let orderWithoutDesc = Order.init(data: ["id": 26, "price": 178,
            "deliver_to": "Oana",
            "address" : "Horia 3, Cluj Napoca",
            "deliverd" : 1,
            "imgUrl" : "https://i.pinimg.com/564x/23/03/2c/23032cbd26824f67862a71082384f83f.jpg"
            ])
        XCTAssertNil(orderWithoutDesc)
        
        // Missing address
        let orderWithoutAddress = Order.init(data: ["id": 26, "description": "Blue Roses",
            "price": 178,
            "deliver_to": "Oana",
            "deliverd" : 1,
            "imgUrl" : "https://i.pinimg.com/564x/23/03/2c/23032cbd26824f67862a71082384f83f.jpg"
            ])
        XCTAssertNil(orderWithoutAddress)
        
        // Missing DeliverTo
        let orderWithoutDeliverTo = Order.init(data: ["id": 26, "description": "Blue Roses",
               "price": 178,
               "address" : "Horia 3, Cluj Napoca",
               "deliverd" : 1,
               "imgUrl" : "https://i.pinimg.com/564x/23/03/2c/23032cbd26824f67862a71082384f83f.jpg"
            ])
        XCTAssertNil(orderWithoutDeliverTo)
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
