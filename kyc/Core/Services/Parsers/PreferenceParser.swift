
public class PreferenceParser{
    
    public class func parseJson(jsonData:NSData)->PreferenceJson{
        
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        return JsonParser.parseDictionaryToType(jsonResult as [NSObject : AnyObject])
    }
    
    
}