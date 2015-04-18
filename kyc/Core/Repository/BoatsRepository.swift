import Foundation

@objc public protocol BoatsRepositoryProtocol {
    func reset()->Bool
    
    func get() -> [BoatDao]
    
    func save(boats: [BoatDao])->Bool
    
    func getBoatByName(boatName:String) -> BoatDao?
}

public class BoatsRepository:NSObject,BoatsRepositoryProtocol{
    
    let repository = Repository<BoatDao>(plist: "Boats")
    
    public func reset()->Bool{
        self.repository.reset()
        return true
    }
    
    public func get() -> [BoatDao]{
        return self.repository.get()
    }
    
    public func save(boats: [BoatDao])->Bool{
        return self.repository.save(boats)
    }
    
    public func getBoatByName(boatName:String) -> BoatDao?{
        if let boat = self.get().filter({ $0.name == boatName }).first{
            return boat
        }
        return nil
    }
}

