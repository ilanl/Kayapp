import Foundation

@objc public protocol DayPrefsRepositoryProtocol {
    func reset()->Bool
    
    func get() -> [DayPrefDao]
    
    func save(boats: [DayPrefDao])->Bool
}

public class DayPrefsRepository:NSObject,DayPrefsRepositoryProtocol{
    
    let repository = Repository<DayPrefDao>(plist: "DayPrefs")
    
    public func reset()->Bool{
        self.repository.reset()
        return true
    }
    
    public func get() -> [DayPrefDao]{
        return self.repository.get()
    }
    
    public func save(dayPref: [DayPrefDao])->Bool{
        return self.repository.save(dayPref)
    }
}


