
public class ForecastParser{

    public class func parseJson(jsonData:NSData,attribute:String)->[ForecastJson]{
        
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        return JsonParser.parseArrayToArrayOfType(jsonResult[attribute] as NSArray)
    }
    
    
}
