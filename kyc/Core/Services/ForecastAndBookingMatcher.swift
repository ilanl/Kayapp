import Foundation

@objc public protocol ForecastAndBookingMatcherProtocol {
    func getSections()->[ForecastSection]
    func getForecastsWithMatchingBookings() -> [ForecastDataCell]
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
    
    public var forecastRepository:ForecastRepository
    public var bookingRepository:BookingRepository
    let dateFormatter = NSDateFormatter()
    
    public init(forecastRepository:ForecastRepository, bookingRepository:BookingRepository){
        
        self.forecastRepository = forecastRepository
        self.bookingRepository = bookingRepository
    }
    
    public func getForecastsWithMatchingBookings() -> [ForecastDataCell]{
        
        var results: [ForecastDataCell] = []
        for forecastDao:ForecastDao in self.forecastRepository.get(){
            
            var appended:Bool = false
            var data: ForecastDataCell = ForecastDataCell()
            data.forecast = ForecastDao(date: forecastDao.datetime, weather: forecastDao.weather, temperature: forecastDao.temperature)
            for bookingDao in self.bookingRepository.get(){
                if let attachedBooking = self.checkIfForecastMatchBookingTime(forecastDao,booking:bookingDao){
                    data.booking = BookingDao(date: bookingDao.datetime
, id: bookingDao.id, boatId: bookingDao.boatId, boatName: bookingDao.boatName, tripId: bookingDao.tripId, state: bookingDao.state, time: bookingDao.time, day: bookingDao.day)
                    
                    data.sectionTitle = self.getSectionName(forecastDao.datetime!)
                    
                    results.append(data)
                    appended = true
                    break
                }
            }
            if !appended{
                data.sectionTitle = self.getSectionName(forecastDao.datetime!)
                results.append(data)
            }
        }
        return results
    }
    
    
    func getSectionName(date:NSDate)->String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE dd MMM"
        let strForecastDay:String = dateFormatter.stringFromDate(date)
        return strForecastDay
    }
    
    public func getSections() -> [ForecastSection]
    {
        var forecastSectionArray:[(title:String,date:NSDate,totalRows:Int)] = []
        
        for forecastDao:ForecastDao in self.forecastRepository.get(){
            
            //Add header
            let strForecastDay = self.getSectionName(forecastDao.datetime!)
            
            let sectionTuple = (title:"\(strForecastDay)",date:forecastDao.datetime!, totalRows:1)
            
            if (forecastSectionArray.count == 0 || forecastSectionArray.last?.title != sectionTuple.title){
                forecastSectionArray.append(sectionTuple)
            }
            else{
                var counter:Int = forecastSectionArray.last!.totalRows
                var tuple = forecastSectionArray.last!
                forecastSectionArray[forecastSectionArray.count-1] = (title:"\(strForecastDay)",date:forecastDao.datetime!, totalRows:++counter)
                
            }
        }
        return forecastSectionArray.map({ ForecastSection(title: $0.title, date: $0.date, totalRows: $0.totalRows) })
    }
    
    private func checkIfForecastMatchBookingTime(forecast:ForecastDao,booking:BookingDao)-> BookingDao?{
        
        if (booking.datetime == nil)
        {
            fatalError("booking must have a time")
        }
        
        if (forecast.datetime == nil)
        {
            fatalError("forecast must have a time")
        }
        
        let interval =  abs(booking.datetime!.minutesFrom(forecast.datetime!))
        
        if (interval >= 0 && interval <= 70){
            return booking
        }
        return nil
    }
}
