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
    
    public var forecastRepository:ForecastRepository
    public var bookingRepository:BookingRepository
    
    public private (set) var forecasts:[ForecastDao] = []
    
    let dateFormatter = NSDateFormatter()
    
    public init(forecastRepository:ForecastRepository, bookingRepository:BookingRepository){
        
        self.forecastRepository = forecastRepository
        self.bookingRepository = bookingRepository
    }
    
    public func getSections() -> [ForecastSection]{
        
        self.forecasts = []
        self.match()
        return self.forecastSectionArray.map({ ForecastSection(title: $0.title, date: $0.date, totalRows: $0.totalRows) })
    }
    
    //MARK: Private methods
    
    private func match()
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE dd MMM"
        
        for forecastDao:ForecastDao in forecastRepository.get(){
            
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
            var f = forecastDao.copy() as! ForecastDao
            for bookingDao in bookingRepository.get(){
                if (self.checkIfForecastMatchBookingTime(forecastDao,booking:bookingDao) == true){
                    
                    println("attaching booking dao")
                    f.attachBooking(bookingDao.copy() as! BookingDao)
                }
            }
            self.forecasts.append(f)
        }
    }
    
    private func checkIfForecastMatchBookingTime(forecast:ForecastDao,booking:BookingDao) -> Bool{
        let bookingTime = booking.datetime
        let interval =  abs(booking.datetime!.minutesFrom(forecast.datetime!))
        
        if (interval < 40){
            return true
        }
        return false
    }
}
