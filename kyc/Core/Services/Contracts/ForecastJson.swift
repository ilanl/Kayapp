

public class ForecastJson:NSObject, Serializable{

    /*
    "Date":"1423641600","Day":"Wednesday","Hour":"06:00 AM","Weather":"353","TempC":"13","WaterTempC":"18","WaveH":"4.9","SwellSecs":"12.2","WindDir":"SW","WindF":"64"
    */
    
    var date:String
    var day:String
    var hour:String
    var weather:String
    var tempC:String
    var waterTempC:String
    var waveH:String
    var swellSecs:String
    var windDir:String
    var windF:String
    
    required public init(dictionary: [NSObject : AnyObject]) {
        self.date = dictionary["Date"] as String
        self.day = dictionary["Day"] as String
        self.hour = dictionary["Hour"] as String
        self.weather = dictionary["Weather"] as String
        self.tempC = dictionary["TempC"] as String
        self.waterTempC = dictionary["WaterTempC"] as String
        self.waveH = dictionary["WaveH"] as String
        self.swellSecs = dictionary["SwellSecs"] as String
        self.windDir = dictionary["WindDir"] as String
        self.windF = dictionary["WindF"] as String
    }
}