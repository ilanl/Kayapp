import Foundation

@objc public protocol ForecastServiceProtocol {
    
    func getWeather(numberOfLiveDays:Int,onSuccess successBlock: (([ForecastDao]) -> Void)?, onError errorBlock: ((String) -> Void)?)
}

public class ForecastService: NSObject, ForecastServiceProtocol {
    
    var forecastRepository:ForecastRepository
    
    public init(forecastRepository:ForecastRepository) {
        self.forecastRepository = forecastRepository
    }
    
    public func getWeather(numberOfLiveDays:Int,onSuccess successBlock: ([ForecastDao] -> Void)?, onError errorBlock: (String -> Void)?)
    {
        //
        var f = ForecastDao(date: NSDate(timeIntervalSince1970: 60000), weather: "WW", temperature: 30)
        let forecasts = [f]
        successBlock!(forecasts)
        
    }
}