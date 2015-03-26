import Foundation

@objc public protocol SettingRepositoryProtocol {
    func reset()->Bool
    
    func get() -> SettingDao?
    
    func save(setting: SettingDao)->Bool
}

public class SettingRepository:NSObject,SettingRepositoryProtocol{
    
    let repository = Repository<SettingDao>(plist: "Setting")
    
    public func reset()->Bool{
        self.repository.reset()
        return true
    }
    
    public func get() -> SettingDao?{
        if let setting = self.repository.get().first{
            return setting
        }
        return nil
    }
    
    public func save(setting: SettingDao)->Bool{
        return self.repository.save([setting])
    }
}