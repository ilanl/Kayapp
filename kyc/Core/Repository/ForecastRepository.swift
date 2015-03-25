import Foundation

@objc public protocol ForecastRepositoryProtocol {
    func reset()->Bool
    
    func get() -> [ForecastDao]
    
    func save(forecasts: [ForecastDao])->Bool
}

public class ForecastRepository:ForecastRepositoryProtocol{
    
    let repository = Repository<ForecastDao>(plist: "Forecasts")
    
    public init(){
        
    }
    
    public func reset()->Bool{
        self.repository.reset()
        return true
    }
    
    public func get() -> [ForecastDao]{
        return self.repository.get()
    }
    
    public func save(forecasts: [ForecastDao])->Bool{
        return self.repository.save(forecasts)
    }
}
