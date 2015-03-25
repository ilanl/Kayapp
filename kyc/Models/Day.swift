import Foundation

public class Day: NSObject{

    var name:String
    var tag:Int
    
    init(day:String,raw:Int) {
        name = day
        tag = raw
        super.init()
    }
    
    class func everydays(){
        let days : [Day] = [Day(day:"Sunday",raw:0),
        Day(day:"Monday",raw:1),
        Day(day:"Tuesday",raw:2),
        Day(day:"Wednesday",raw:3),
        Day(day:"Thursday",raw:4),
        Day(day:"Friday",raw:5),
        Day(day:"Saturday",raw:6)]
        }
}