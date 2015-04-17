import Foundation

@objc public protocol ForecastServiceProtocol {
    
    func getWeather(numberOfLiveDays:Int,onSuccess successBlock: (([ForecastDao]) -> Void)?, onError errorBlock: ((String) -> Void)?)
}

public class ForecastService:NSObject, ForecastServiceProtocol {
    
    var forecastRepository:ForecastRepository?
    var configReader:ConfigReader?
    
    public init(forecastRepository:ForecastRepository, configReader:ConfigReader) {
        self.forecastRepository = forecastRepository
        self.configReader = configReader
    }
    
    public func getWeather(numberOfLiveDays:Int,onSuccess successBlock: ([ForecastDao] -> Void)?, onError errorBlock: (String -> Void)?)
    {
        let url:NSURL = NSURL(string: self.configReader!.getForecastUrl)!
        
        JsonClient.get(url){ (data:NSData) -> Void in
            
            let forecasts = ForecastParser.parseJson(data, attribute: "Forecasts")
            
            if forecasts.count == 0{
                errorBlock!("Could not fetch any forecasts")
                return
            }
            var forecastDaos = [ForecastDao]()
            for f in forecasts
            {
                let timeinterval : NSTimeInterval = (f.date as! NSString).doubleValue
                let temperature : Int = (f.tempC as! NSString).integerValue
                let date:NSDate? = NSDate(timeIntervalSince1970: timeinterval) as! NSDate?
                let forecastDao = ForecastDao(date: date, weather: f.weather, temperature: temperature)
                forecastDaos.append(forecastDao)
            }
            self.forecastRepository!.save(forecastDaos)
            
            successBlock!(forecastDaos)
        }
    }
}