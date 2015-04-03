import Foundation
import XCTest
import kyc

public class PreferenceParserTests : XCTestCase {
    
    public func test_parse_preference_json() {
        
        var jsonData = JsonParser.readJson(NSBundle(forClass:PreferenceParserTests.self),fileName:"preferenceData")
        XCTAssertNotNil(jsonData, "Incorrect Json contents")
        var preferenceJson:PreferenceJson = PreferenceParser.parseJson(jsonData)
        XCTAssertNotNil(preferenceJson, "Incorrect Json Array")
        XCTAssertFalse(
            preferenceJson.isFrozen!, "isFrozen not correct")
        XCTAssert(
            preferenceJson.reminder! == 0, "reminder is not correct")
        
        XCTAssertNotNil(preferenceJson.set.arrayOfKayakPrefs[0].name)
        XCTAssertNotNil(preferenceJson.set.arrayOfKayakPrefs[0].type)
        XCTAssertNotNil(preferenceJson.set.arrayOfKayakPrefs[0].key)
        
        XCTAssertNotNil(preferenceJson.set.arrayOfTimePrefs[0].time)
        XCTAssertNotNil(preferenceJson.set.arrayOfTimePrefs[0].type)
        XCTAssertNotNil(preferenceJson.set.arrayOfTimePrefs[0].dayOfWeek)
        
        
    }
}
