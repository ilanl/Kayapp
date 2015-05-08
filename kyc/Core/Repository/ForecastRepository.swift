import Foundation

@objc public protocol ForecastRepositoryProtocol {
    func reset()->Bool
    
    func get(filter filterBlock: (ForecastDao -> Bool)?) -> [ForecastDao]
    
    func save(forecasts: [ForecastDao])->Bool
}

public class ForecastRepository:NSObject,ForecastRepositoryProtocol{
    
    var repository = Repository<ForecastDao>(plist: "Forecasts")
    public func reset()->Bool{
        self.repository.reset()
        return true
    }
    
    public func get(filter filterBlock: (ForecastDao -> Bool)?) -> [ForecastDao]{
        
        var arraySortable:Array<ForecastDao> = []
        
        if let filterCondition = filterBlock{
            arraySortable = self.repository.get().filter(filterCondition)
        }
        else{
            arraySortable = self.repository.get()
        }
        
        arraySortable.sort({
            let interval = $1.datetime!.timeIntervalSinceDate($0.datetime!)
            return interval > 0 })
        return arraySortable
    }
    
    public func save(forecasts: [ForecastDao])->Bool{
        return self.repository.save(forecasts)
    }
}
