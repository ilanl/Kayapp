import Foundation

public class Day: NSObject{

    var name:String
    var tag:Int
    
    init(day:String,raw:Int) {
        name = day
        tag = raw
        super.init()
    }
    
    public class func getDayByString(dayOfWeek:String)->Int{
        return everydays().filter({ $0.name == dayOfWeek }).first!.tag
    }
    
    class func everydays() -> [Day]{
        let days : [Day] = [
            Day(day:"Sunday",raw:1),
            Day(day:"Monday",raw:2),
            Day(day:"Tuesday",raw:3),
            Day(day:"Wednesday",raw:4),
            Day(day:"Thursday",raw:5),
            Day(day:"Friday",raw:6),
            Day(day:"Saturday",raw:7)]
        
            return days
        }
}