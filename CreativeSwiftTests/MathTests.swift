//
//  CreativeSwiftTests.swift
//  CreativeSwiftTests
//
//  Created by Wirawit Rueopas on 1/22/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import XCTest
import CreativeSwift

class MathTests: XCTestCase {
    
    func testBasicMaths() {
        
        XCTAssertTrue(sum(1, 2, 4, 5) == (1+2+4+5))
        XCTAssertTrue(sum([1, 2, 4, 5]) == (1+2+4+5))
        XCTAssertTrue(sum([1, 2, -4, 5]) == (1+2-4+5))
        XCTAssertTrue(sum([]) == 0)
        
        
        XCTAssertTrue(avg([1, 2, 4, 5]) == (1+2+4+5)/4.0)
        XCTAssertTrue(avg([1, 2, -4, 5]) == (1+2-4+5)/4.0)
        XCTAssertTrue(avg([]) == 0)
        
        let p1 = CGPoint(x: 4, y: 5)
        let p2 = CGPoint(x: 60, y: 20)
        
        XCTAssertTrue(avg(points: p1, p2) == CGPoint(x: 32, y: 12.5))
        XCTAssertTrue(avg(points: [p1, p2]) == CGPoint(x: 32, y: 12.5))
        XCTAssertTrue(p1*5 == CGPoint(x: 20, y: 25))
        
        let p3 = p2/4
        XCTAssertTrue(p3.x == 15)
        XCTAssertTrue(p3.y == 5)
        
        XCTAssertTrue(p1+p2 == CGPoint(x: 64, y: 25))
        XCTAssertTrue(mag(p: p1) == sqrt(41))
        XCTAssertTrue(magsq(p: p1) == 41)
        XCTAssertTrue(dist(p1: p1, p2: p2) == sqrt(3361))
        XCTAssertTrue(distsq(p1: p1, p2: p2) == 3361)
        
        XCTAssertTrue(lerp(start: 20, stop: 36, amt: 0) == 20)
        XCTAssertTrue(lerp(start: 20, stop: 36, amt: 0.2) == 23.2)
        XCTAssertTrue(lerp(start: 20, stop: 36, amt: 1) == 36)
        XCTAssertTrue(lerp(start: 20, stop: 36, amt: -0.5) == 12)
        
        XCTAssertTrue(norm(value: 19, low: 10, high: 20) == 0.9)
        XCTAssertTrue(norm(value: 19, low: 0, high: 19) == 1)
        XCTAssertTrue(norm(value: 12, low: 0, high: 10) == 1.2)
        XCTAssertTrue(norm(value: 0, low: -10, high: 10) == 0.5)
        
        XCTAssertTrue(range(min: 0, max: 5) == [0, 1, 2, 3, 4, 5])
        XCTAssertTrue(range(min: -2, max: 2) == [-2, -1, 0, 1, 2])
        XCTAssertTrue(range(min: 2, max: 2) == [2])
        XCTAssertTrue(range(min: 2, max: -2) == [])
        
        XCTAssertTrue(rangef(min: -1, max: 3, step: 0.5) == [-1.0, -0.5, 0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0])
        let res = rangef(min: -1, max: 3, step: 0.3)
        XCTAssertEqualWithAccuracy(res.max()!, 2.9, accuracy: 0.1)
        XCTAssertEqualWithAccuracy(res.min()!, -1.0, accuracy: 0.1)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
