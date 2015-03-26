import XCTest
import kyc

public class SettingRepositoryTests: XCTestCase {
    var target : SettingRepository!
    
    public override func setUp() {
        
        let factory = TyphoonBlockComponentFactory(assemblies: [CoreComponents()])
        self.target = factory.componentForKey("settingRepositoryFactory") as? SettingRepository
        self.target.reset()
    }
    
    public func test_get_and_save_setting() {
        
        let mode = 1
        var reminder:Int? = nil
        
        var setting = SettingDao(mode:mode, reminder:nil)
        
        let savedResult = self.target.save(setting)
        XCTAssertTrue(savedResult)
        
        var savedSetting = self.target.get()!
        
        XCTAssertEqual(savedSetting.mode,mode, "Incorrect mode")
        XCTAssertNil(savedSetting.reminder)
        
        reminder = 30
        setting = SettingDao(mode:mode, reminder:reminder)
        self.target.save(setting)
        savedSetting = self.target.get()!
        
        XCTAssertEqual(savedSetting.reminder!,reminder!, "Incorrect reminder")
    }
}
