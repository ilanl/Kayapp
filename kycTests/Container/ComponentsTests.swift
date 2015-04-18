import Foundation
import XCTest
import kyc

public class ComponentsTests : XCTestCase {
    
    public func test_transient_booking_service() {
        
        let factory = TyphoonBlockComponentFactory(assemblies: [CoreComponents()])
        var target = factory.componentForKey("bookingServiceFactory") as! BookingService
        
        XCTAssertNotNil(target, "Booking service is Null")
    }
    
    public func test_transient_preference_service() {
        
        let factory = TyphoonBlockComponentFactory(assemblies: [CoreComponents()])
        var target = factory.componentForKey("preferenceServiceFactory") as! PreferenceService
        
        let expectation = expectationWithDescription("expecting data")
        
        target.getPreferences({ (boats, boatPrefs, dayPrefs, setting) -> Void in
            
            expectation.fulfill()
            
            }, onError: { (message) -> Void in
                
                expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(10.0, handler:nil)
    }
    
    public func test_transient_forecast_service() {
        
        let factory = TyphoonBlockComponentFactory(assemblies: [CoreComponents()])
        var target = factory.componentForKey("forecastServiceFactory") as! ForecastService
        
        let expectation = expectationWithDescription("expecting data")
        target.getWeather(5, onSuccess: { forecasts in
            
            XCTAssertTrue(true, "failed to run success block")
            expectation.fulfill()
            
            }, onError: { (message) -> Void in
                
                expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5.0, handler:nil)
    }
    
    public func test_singleton_repository() {
        
        let factory = TyphoonBlockComponentFactory(assemblies: [CoreComponents()])
        var target = factory.componentForKey("forecastRepositoryFactory") as! ForecastRepository
        
        target.save([ForecastDao(date: nil, weather: "some weather", temperature: 10)])
        
        for var i=0;i<10;i++ {
            var target2 = factory.componentForKey("forecastRepositoryFactory") as! ForecastRepository
            
            let results = target2.get()
        }
        var target2 = factory.componentForKey("forecastRepositoryFactory") as! ForecastRepository
        
        let results = target2.get()
        XCTAssertTrue(results.count == 1, "Not singleton")
    }
}
