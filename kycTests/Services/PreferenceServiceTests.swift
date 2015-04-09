import Foundation
import XCTest
import kyc

public class PreferenceServiceTests : XCTestCase {
    
    var target : PreferenceService!
    
    var boatsRepository = BoatsRepositoryDummy()
    var boatPrefsRepository = BoatPrefsRepositoryDummy()
    var dayPrefsRepository = DayPrefsRepositoryDummy()
    var userRepository=UserRepositoryDummy()
    var settingRepository=SettingRepositoryDummy()
    
    public override func setUp() {
        
        self.target = PreferenceService(boatsRepository: self.boatsRepository, boatPrefsRepository: self.boatPrefsRepository, dayPrefsRepository: self.dayPrefsRepository, userRepository: self.userRepository, settingRepository: self.settingRepository)
    }
    
    public func test_preference_service_get() {
        
        let expectation = expectationWithDescription("expecting data")
        
        self.target.getPreferences({ (boats, boatPrefs, dayPrefs, setting) -> Void in
            
            XCTAssertTrue(boats!.count > 0, "Could not find boats")
            XCTAssertTrue(boatPrefs!.count > 0, "Could not find boat prefs")
            XCTAssertTrue(dayPrefs!.count > 0, "Could not find day prefs")
            XCTAssertTrue(setting !=  nil, "Could not find setting")
            
            expectation.fulfill()
            
        }, onError: { (message) -> Void in
            //
        })
        
        waitForExpectationsWithTimeout(60.0, handler:nil)
    }
    
    public func test_preference_service_save() {
        
        let expectation = expectationWithDescription("expecting data")
        
        self.dayPrefsRepository.save([DayPrefDao(day: 1, time: 1, type: 1)])
        self.boatPrefsRepository.save([BoatPrefDao(name: "ss", order: 1)])
        self.settingRepository.save(SettingDao(mode: 1, reminder: 30))
        
        self.target.savePreferences({ (boats, boatPrefs, dayPrefs, setting) -> Void in
            
            expectation.fulfill()
            
            }, onError: { (message) -> Void in
                //
                
                println("handle errors here")
        })
        
        waitForExpectationsWithTimeout(200.0, handler:nil)
    }
    
    public class BoatsRepositoryDummy: BoatsRepository{
        public var inMemoryRepository = [BoatDao]()
        
        override public func save(boats: [BoatDao]) -> Bool {
            self.inMemoryRepository = boats
            println("saving boats somewhere")
            return true
        }
    }
    
    public class BoatPrefsRepositoryDummy: BoatPrefsRepository{
        public var inMemoryRepository = [BoatPrefDao]()
        
        override public func save(boatPrefs: [BoatPrefDao]) -> Bool {
            self.inMemoryRepository = boatPrefs
            println("saving boats somewhere")
            return true
        }
    }
    
    public class DayPrefsRepositoryDummy: DayPrefsRepository{
        public var inMemoryRepository = [DayPrefDao]()
        
        override public func save(dayPrefs: [DayPrefDao]) -> Bool {
            self.inMemoryRepository = dayPrefs
            println("saving boats somewhere")
            return true
        }
    }
    
    public class UserRepositoryDummy: UserRepository{
        public var inMemoryRepository = UserDao(name:"dd",pwd:"sss")
        
        public override func get() -> UserDao? {
            
            var userDao = UserDao(name: "%D7%90%D7%99%D7%9C%D7%9F%20%D7%9C", pwd: "32371")
            userDao.deviceToken = "7851dc5ce47f31105238767b8e45614789bb46542e4b251fb7b685982dbc4e47"
            return userDao
        }
    }
    
    public class SettingRepositoryDummy: SettingRepository{
        public var inMemoryRepository: SettingDao?
        
        public override func get() -> SettingDao? {
            return inMemoryRepository
        }
        
        public override func save(setting: SettingDao) -> Bool {
            self.inMemoryRepository = setting
            println("saving settings somewhere")
            return true
        }
    }
}



