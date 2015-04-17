import Foundation
import XCTest
import kyc

public class ForecastServiceTests : XCTestCase {
    
    var target : ForecastService!
    var repositoryDummy = ForecastRepositoryDummy()
    var configReaderDummy = ConfigReaderDummy()
    
    public override func setUp() {
        
        self.target = ForecastService(forecastRepository:self.repositoryDummy, configReader: self.configReaderDummy)
    }
    
    public func test_forecast_service_live() {
    
        let expectation = expectationWithDescription("expecting data")
        
        self.target.getWeather(5, onSuccess: { forecasts in
            println("completed BLOCK SUCCESS")
            XCTAssertTrue(true, "failed to run success block")
            expectation.fulfill()
            
        }, onError: nil)
        
        waitForExpectationsWithTimeout(5.0, handler:nil)
        
        XCTAssertNotNil(self.repositoryDummy.inMemoryRepository[0],"did not saved")
    }
    
    public class ForecastRepositoryDummy: ForecastRepository{
        public var inMemoryRepository = [ForecastDao]()
        
        override public func save(forecasts: [ForecastDao]) -> Bool {
            self.inMemoryRepository = forecasts
            println("saving forecasts somewhere")
            return true
        }
    }
}



