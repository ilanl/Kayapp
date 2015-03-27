import Foundation
import XCTest
import kyc

public class ForecastParserTests : XCTestCase {
    
    public func test_parse_forecast_json() {
        
        var jsonData = JsonParser.readJson(NSBundle(forClass:ForecastParserTests.self),fileName:"weatherData")
        XCTAssertNotNil(jsonData, "Incorrect Json contents")
        var forecastJsonArray = ForecastParser.parseJson(jsonData,attribute: "Forecasts")
        XCTAssertNotNil(forecastJsonArray, "Incorrect Json Array")
    }
}


