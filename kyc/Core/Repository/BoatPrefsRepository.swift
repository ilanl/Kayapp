import Foundation

@objc public protocol BoatPrefsRepositoryProtocol {
    func reset()->Bool
    
    func get() -> [BoatPrefDao]
    
    func save(boats: [BoatPrefDao])->Bool
    
    func saveOne(boatPref: BoatPrefDao)->Bool
    
    func deleteOne(boatPref: BoatPrefDao)->Bool
}

public class BoatPrefsRepository:NSObject,BoatPrefsRepositoryProtocol{
    
    let repository = Repository<BoatPrefDao>(plist: "BoatPrefs")
    
    public func reset()->Bool{
        self.repository.reset()
        return true
    }
    
    public func get() -> [BoatPrefDao]{
        return self.repository.get()
    }
    
    public func save(dayPref: [BoatPrefDao])->Bool{
        return self.repository.save(dayPref)
    }
    
    public func saveOne(boatPref: BoatPrefDao)->Bool{
        return self.repository.saveOne(boatPref)
    }
    
    public func deleteOne(boatPref: BoatPrefDao)->Bool{
        return self.repository.delete(boatPref)
    }
}


