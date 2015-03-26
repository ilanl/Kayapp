import Foundation
import XCTest
import kyc

public class ForecastServiceTests : XCTestCase {
    
    var target : ForecastService!
    
    public override func setUp() {
        
        self.target = ForecastService(forecastRepository:ForecastRepositoryDummy())
    }
    
    public func test_forecast_service_live() {
        
        self.target.getWeather(5, onSuccess: { forecasts in
            println("completed BLOCK SUCCESS")
            XCTAssertTrue(true, "failed to run success block")
        }, onError: nil)
    }
    
    class ForecastRepositoryDummy: ForecastRepository{
        override func save(forecasts: [ForecastDao]) -> Bool {
            println("saving forecasts somewhere")
            return true
        }
    }
}



