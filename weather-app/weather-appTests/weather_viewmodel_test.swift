//
//  weather_viewmodel_test.swift
//  weather-appTests
//
//  Created by Agustin Errecalde on 12/10/2021.
//

import Foundation
import XCTest
@testable import weather_app

class weather_viewmodel_test: XCTestCase {
    
    var sut: WeatherViewModel!
    
    override func setUp() {
        super.setUp()
        sut = WeatherViewModel(pageViewModels: [WeatherPageViewModel(weather: WeatherModel.lastWeatherSaved),
                                                WeatherPageViewModel(weather: WeatherModel.lastWeatherSaved),
                                                WeatherPageViewModel(weather: WeatherModel.lastWeatherSaved)])
    }
    func test_getIndexWithNegativeOffsetNotThrow() {
        sut.offset = CGFloat(-10000)
        XCTAssertNoThrow(sut.getIndex())
    }
    
    func test_indexWithNegativeOffsetIsEqualTo0() {
        sut.offset = CGFloat(-1000)
        XCTAssertTrue(sut.getIndex() == 0)
    }
    
    func test_indexInRangeResponseCorrectValue() {
        let screenWidthSize = UIScreen.main.bounds.width
        sut.offset = CGFloat(screenWidthSize * 2)
        XCTAssertTrue(sut.getIndex() == 2 )
    }
    
    func test_indexIsGreatherThanMaxValue() {
        let screenWidthSize = UIScreen.main.bounds.width
        sut.offset = CGFloat(screenWidthSize * 5)
        XCTAssertTrue(sut.getIndex() == (sut.pageViewModels.count - 1))
    }
    
    func test_pageViewModelsIsEmpty() {
        guard !sut.pageViewModels.isEmpty else { return }
        sut.pageViewModels.removeAll()
        XCTAssertNoThrow(sut.getIndex())
    }
    
    func test_pageViewModelsIsEmptyResponseDefaultVal() {
        guard !sut.pageViewModels.isEmpty else { return }
        sut.pageViewModels.removeAll()
        XCTAssertEqual(sut.getIndex(), 0)
    }
    
    func testIsSelectedCorrectVal() {
        let screenWidthSize = UIScreen.main.bounds.width
        sut.offset = CGFloat(screenWidthSize * 2)
        XCTAssertTrue(sut.isSelected(index: 2))
    }

}
