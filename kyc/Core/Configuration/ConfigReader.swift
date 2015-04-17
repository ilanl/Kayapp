import Foundation

@objc public protocol ConfigReaderProtocol {
    
    var getPreferenceUrl: String { get }
    var savePreferenceUrl: String { get }
    var getForecastUrl: String { get }
    var getBookingUrl: String { get }
}

public class ConfigReader:NSObject, ConfigReaderProtocol{
    
    public var getPreferenceUrl: String
    public var savePreferenceUrl: String
    public var getForecastUrl: String
    public var getBookingUrl: String
    
    public required override init(){
        
        let path = NSBundle.mainBundle().pathForResource("config", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        
        self.getPreferenceUrl = (dict!.valueForKey("getPreferenceUrl") as! String)
        self.savePreferenceUrl = dict!.valueForKey("savePreferenceUrl") as! String
        self.getForecastUrl = dict!.valueForKey("getForecastUrl") as! String
        self.getBookingUrl = dict!.valueForKey("getBookingUrl") as! String
    }
}