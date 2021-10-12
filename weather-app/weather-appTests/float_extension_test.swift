//
//  float_extension_test.swift
//  weather-appTests
//
//  Created by Agustin Errecalde on 12/10/2021.
//

import Foundation
import XCTest
@testable import weather_app

class float_extension_test: XCTestCase {
    
    var sut: Float!
    var valExpected: Float!
    
    override func setUp() {
        super.setUp()
        sut = 600
        valExpected = 1200
    }
    
    func test_convertToPercentageCorrectValue() {
        XCTAssertEqual(sut.getValueFromPercentage(value: 200), valExpected)
    }
    
    func test_convertToPercentageNotTrhowErrorIf0() {
        XCTAssertNoThrow(Float(0).getValueFromPercentage(value: 1000))
    }
    
    func test_convertToPercentageNotTrhowErrorIfValueIs0() {
        XCTAssertNoThrow(Float(0).getValueFromPercentage(value: 0))
        XCTAssertEqual(Float(0).getValueFromPercentage(value: 0), 0)
    }
    
    func test_convertToPercentageNotTrhowErrorIfNegativeValues() {
        XCTAssertNoThrow((-sut).getValueFromPercentage(value: 0))
        XCTAssertEqual((-sut).getValueFromPercentage(value: -200), valExpected)
    }
}
