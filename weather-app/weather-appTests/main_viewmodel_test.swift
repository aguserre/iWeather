//
//  main_viewmodel_test.swift
//  weather-appTests
//
//  Created by Agustin Errecalde on 05/10/2021.
//

import XCTest
@testable import weather_app

class main_viewmodel_test: XCTestCase {
    
    var sut = MainViewModel()
    
    func test_buttonTitleWithNegativeServiceError() {
        sut.retrysCount = -5
        sut.errorType = .service
        XCTAssertTrue(sut.alertButtonTitle == "Retry")
    }
    
    func test_buttonTitleWithoutServiceError() {
        sut.retrysCount = 0
        sut.errorType = .service
        XCTAssertTrue(sut.alertButtonTitle == "Retry")
    }
    
    func test_buttonTitleWithOneServiceError() {
        sut.retrysCount = 1
        sut.errorType = .service
        XCTAssertTrue(sut.alertButtonTitle == "Retry")
    }
    
    func test_buttonTitleWithTwoServiceError() {
        sut.retrysCount = 2
        sut.errorType = .service
        XCTAssertTrue(sut.alertButtonTitle == "Retry")
    }
    
    func test_buttonTitleWithThreeServiceError() {
        sut.retrysCount = 3
        sut.errorType = .service
        XCTAssertTrue(sut.alertButtonTitle == "Ok")
    }
    
    func test_buttonTitleWithFourServiceError() {
        sut.retrysCount = 4
        sut.errorType = .service
        XCTAssertFalse(sut.alertButtonTitle == "Retry")
    }

}
