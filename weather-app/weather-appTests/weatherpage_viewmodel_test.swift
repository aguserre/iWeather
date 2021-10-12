//
//  weatherpage_viewmodel_test.swift
//  weather-appTests
//
//  Created by Agustin Errecalde on 12/10/2021.
//

import Foundation
import XCTest
@testable import weather_app

class weatherpage_viewmodel_test: XCTestCase {

    var sut: WeatherPageViewModel!
    var model: WeatherModel!
    
    override func setUp() {
        super.setUp()
        model = WeatherModelFake().fakeWeather
        sut = WeatherPageViewModel(weather: model)
    }
    
    func test_getCorrectSpacesIfTwooCharacters() {
        XCTAssertTrue(sut.getSpaces() == 30)
    }
    
    func test_getCorrectSpacesIfThreeCharacters() {
        let main = MainData(temp: 123, feels_like: 0, temp_min: 0, temp_max: 0, pressure: 0, humidity: 0)
        let fakeWeather = WeatherModelFake(main: main).fakeWeather
        let vm = WeatherPageViewModel(weather: fakeWeather)
        
        XCTAssertTrue(vm.getSpaces() == 60)
    }
    
    func test_CorrectFormatTempViewModelBuilder() {
        let vm = sut.getTempViewModel()
        
        XCTAssertTrue(vm.cityName == model.name)
        XCTAssertTrue(vm.currentTemp == String(Int(model.main.temp)))
        XCTAssertTrue(vm.spaces == sut.getSpaces())
        XCTAssertTrue(vm.weatherDescription == model.weather.first?.description ?? "")
        
        let minTemp = String(model.main.temp_min)
        XCTAssertTrue(vm.minTemp == "L: \(minTemp)º")
        
        let maxTemp = String(model.main.temp_max)
        XCTAssertTrue(vm.maxTemp == "H: \(maxTemp)º")
        XCTAssertTrue(vm.icon == model.weather.first?.icon ?? "sun.fill")
    }
    
    func test_CorrectFormatVisibilityViewModelBuilder() {
        let vm = sut.getVisibilityCardViewModel()
        
        XCTAssertTrue(vm.title == "Visibility")
        XCTAssertTrue(vm.imageTitle == "eye")
        XCTAssertTrue(vm.description == "\(model.visibility) m")
    }
    
    func test_CorrectFormatWindCardViewModelBuilder() {
        let vm = sut.getWindCardViewModel()
        
        XCTAssertTrue(vm.title == "Wind")
        XCTAssertTrue(vm.imageTitle == "wind")
        XCTAssertTrue(vm.description == "\(model.wind.speed) m/s")
    }
    
    func test_CorrectFormatSunCardViewModelBuilder() {
        let vm = sut.getSunCardViewModel()
        
        XCTAssertTrue(vm.currentPercent == CGFloat(model.currentInHours*100/24))
        XCTAssertTrue(vm.isNight == model.isNight)
        XCTAssertTrue(vm.sunsetText == "Sunset: \(model.sunsetInHours) Hs")
        XCTAssertTrue(vm.sunriseText == "Sunrise: \(model.sunriseInHours) Hs")
        XCTAssertTrue(vm.currentTime == model.currentTime)
    }
    
    func test_CorrectFormatPressureCardViewModelBuilder() {
        let vm = sut.getPressureCardViewModel()
        
        XCTAssertTrue(vm.title == "Pressure")
        XCTAssertTrue(vm.imageTitle == "barometer")
        XCTAssertTrue(vm.description == "\(model.main.pressure) hPa")
    }
    
    func test_CorrectFormatHumidityCardViewModelBuilder() {
        let vm = sut.getHumidityCardViewModel()
        
        XCTAssertTrue(vm.title == "Humidity")
        XCTAssertTrue(vm.imageTitle == "wind")
        XCTAssertTrue(vm.description == "\(model.main.humidity)%")
    }
    
    func test_CorrectFormatMapCardViewModelBuilder() {
        let vm = sut.getMapCardViewModel()
        
        XCTAssertTrue(vm.region.center.longitude == model.coord.lon)
        XCTAssertTrue(vm.region.center.latitude == model.coord.lat)
    }
    
}
