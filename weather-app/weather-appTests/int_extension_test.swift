//
//  int_extension_test.swift
//  weather-appTests
//
//  Created by Agustin Errecalde on 12/10/2021.
//

import XCTest
@testable import weather_app

class int_extension_test: XCTestCase {
    
    var sut: Int!
    var expectedHour: Int!
    let fakeCurrentTime = -10800
    
    override func setUp() {
        super.setUp()
        sut = 1633969221
        expectedHour = 13
    }
    
    func test_convertToHourDayGetCorrectValue() {
        let hours = sut.convertToHourDay(timeFromGMT: fakeCurrentTime)
        XCTAssertTrue(hours == expectedHour)
    }
    
    func test_convertToHourDayNotErrorIf0() {
        XCTAssertNoThrow(sut.convertToHourDay(timeFromGMT: 0))
    }
    
    func test_convertToHourDayNotErrorIfLongNegative() {
        XCTAssertNoThrow(sut.convertToHourDay(timeFromGMT: -564898516560))
    }
    
    func test_convertToHourDayNotErrorIfLongPositive() {
        XCTAssertNoThrow(sut.convertToHourDay(timeFromGMT: 564898516560))
    }
    
    func test_convertToCurrentTimeDayGetCorrectValue() {
        let timeFormatted = sut.convertToCurrentTime(timeFromGMT: fakeCurrentTime)
        XCTAssertEqual(timeFormatted, "13 : 20")
    }
    
    func test_convertToCurrentTimeNotErrorIf0() {
        XCTAssertNoThrow(sut.convertToCurrentTime(timeFromGMT: 0))
    }
    
    func test_convertToCurrentTimeNotErrorIfLongNegative() {
        XCTAssertNoThrow(sut.convertToCurrentTime(timeFromGMT: -564898516560))
    }
    
    func test_convertToCurrentTimeNotErrorIfLongPositive() {
        XCTAssertNoThrow(sut.convertToCurrentTime(timeFromGMT: 564898516560))
    }
    
    func test_convertToPercentageCorrectValue() {
        XCTAssertTrue(500.convertToPercentage(maxValue: 1000) == 50)
    }
    
    func test_convertToPercentageNotTrhowErrorIf0() {
        XCTAssertNoThrow(0.convertToPercentage(maxValue: 1000))
    }
    
    func test_convertToPercentageNotTrhowErrorMaxValue0() {
        XCTAssertNoThrow(500.convertToPercentage(maxValue: 0))
        XCTAssertTrue(500.convertToPercentage(maxValue: 0) == 0)
        XCTAssertTrue(0.convertToPercentage(maxValue: 0) == 0)
    }
    
    func test_convertToPercentageWithNegativeValuesNotThrow() {
        XCTAssertNoThrow(500.convertToPercentage(maxValue: (-1000)))
        XCTAssertTrue(500.convertToPercentage(maxValue: (-1000)) == 50)
        
        XCTAssertNoThrow((-500).convertToPercentage(maxValue: (-1000)))
        XCTAssertTrue((-500).convertToPercentage(maxValue: (-1000)) == 50)
    }

}
