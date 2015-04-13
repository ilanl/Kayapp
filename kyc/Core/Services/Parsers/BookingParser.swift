
public class BookingParser{
    
    public class func parseJson(jsonData:NSData)->BookingJson{
        
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        return JsonParser.parseDictionaryToType(jsonResult as [NSObject : AnyObject])
    }
    
    
}