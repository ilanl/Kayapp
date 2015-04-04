import Foundation

public class Time: NSObject{
    
    var name:String
    var tag:Int
    
    init(time:String,raw:Int) {
        name = time
        tag = raw
        super.init()
    }
    
    public class func getTimeByString(timeOfDay:String)->Int{
        return everytimes().filter({ $0.name == timeOfDay }).first!.tag
    }
    
    class func everytimes() -> [Time]{
        let times : [Time] = [
            Time(time:"Morning",raw:1),
            Time(time:"Afternoon",raw:2),
            Time(time:"Evening",raw:3)]
        return times
    }
}