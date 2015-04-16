import Foundation

@objc public protocol DayPrefsRepositoryProtocol {
    func reset()->Bool
    
    func get() -> [DayPrefDao]
    
    func save(boats: [DayPrefDao])->Bool
    
    func saveOne(dayPrefOne: DayPrefDao)->Bool
    
    func deleteOne(dayPref: DayPrefDao)->Bool
}

public class DayPrefsRepository:NSObject,DayPrefsRepositoryProtocol{
    
    let repository = Repository<DayPrefDao>(plist: "DayPrefs")
    
    public func reset()->Bool{
        self.repository.reset()
        return true
    }
    
    public func get() -> [DayPrefDao]{
        var list = self.repository.get()
        return list
    }
    
    public func save(dayPref: [DayPrefDao])->Bool{
        return self.repository.save(dayPref)
    }
    
    public func saveOne(dayPrefOne: DayPrefDao)->Bool{
        
        let type = dayPrefOne.type
        let day  = dayPrefOne.day
        let time = dayPrefOne.time
        
        if (type == 0){
            if let existingPref = self.repository.get().filter({ $0.day == day && $0.time == time }).first{
                return self.repository.delete(existingPref)
            }
        }
        else if (type == 1 || type == 2){
            return self.repository.saveOne(dayPrefOne)
        }
        
        return false
    }
    
    public func deleteOne(dayPref: DayPrefDao)->Bool{
        return self.repository.delete(dayPref)
    }
}


