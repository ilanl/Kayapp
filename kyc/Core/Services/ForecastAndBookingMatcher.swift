import Foundation

@objc public protocol ForecastAndBookingMatcherProtocol {
    func getSections()->([ForecastSection])
}

public class ForecastSection:NSObject{
    var title:String
    var date:NSDate
    var totalRows:Int
    
    init(title:String,date:NSDate,totalRows:Int){
        self.title = title
        self.date = date
        self.totalRows = totalRows
    }
}

public class ForecastAndBookingMatcher:NSObject,ForecastAndBookingMatcherProtocol{
    
    private var forecastSectionArray:[(title:String,date:NSDate,totalRows:Int)] = []
    public private (set) var forecasts:[ForecastDao]
    public private (set) var bookings:[BookingDao]
    
    let dateFormatter = NSDateFormatter()
    
    public init(forecastRepository:ForecastRepository, bookingRepository:BookingRepository){
        
        self.forecasts = forecastRepository.get()
        self.bookings = bookingRepository.get()
    }
    
    public func getSections() -> [ForecastSection]{
        self.match()
        return self.forecastSectionArray.map({ ForecastSection(title: $0.title, date: $0.date, totalRows: $0.totalRows) })
    }
    
    //MARK: Private methods
    
    private func match()
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE dd MMM"
        let allAvailableForecasts = self.forecasts
        
        for forecastDao in allAvailableForecasts{
            
            if (forecastDao.datetime == nil){
                continue
            }
            
            //Add header
            let strForecastDay = dateFormatter.stringFromDate(forecastDao.datetime!)
            
            let sectionTuple = (title:"\(strForecastDay)",date:forecastDao.datetime!, totalRows:1)
            
            if (self.forecastSectionArray.last?.title != sectionTuple.title){
                self.forecastSectionArray.append(sectionTuple)
            }
            else{
                var counter:Int = self.forecastSectionArray.last!.totalRows
                var tuple = self.forecastSectionArray.last!
                self.forecastSectionArray[self.forecastSectionArray.count-1] = (title:"\(strForecastDay)",date:forecastDao.datetime!, totalRows:++counter)
                
            }
            
            for bookingDao in self.bookings{
                if (self.checkIfForecastMatchBookingTime(forecastDao,booking:bookingDao) == true){
                    
                    forecastDao.booking = bookingDao
                    break
                }
            }
        }
    }
    
    private func checkIfForecastMatchBookingTime(forecast:ForecastDao,booking:BookingDao) -> Bool{
        let bookingTime = booking.datetime
        let interval =  booking.datetime!.minutesFrom(forecast.datetime!)
        
        println("booking: \(booking.datetime!)")
        println("forecast: \(forecast.datetime!)")
        println("interval: \(interval)")
        
        if (interval < 0){
            return false
        }
        
        if (interval < 180){
            return true
        }
        return false
    }
}
