public protocol Serializable {
    init(dictionary: [NSObject: AnyObject])
}

public class JsonParser:NSObject{
    
    public class func parseDictionaryToType<T: Serializable>(dictionary: [NSObject: AnyObject]) -> T {
        let parsedObject = T(dictionary: dictionary)
        return parsedObject
    }
    
    public class func parseArrayToArrayOfType<T: Serializable>(array: [AnyObject]) -> [T] {
        var parsedArray = [T]()
        for object in array {
            let dictionary = object as [NSObject: AnyObject]
            let parsedObject: T = parseDictionaryToType(dictionary)
            parsedArray.append(parsedObject)
        }
        return parsedArray
    }
    
    public class func readJson(bundle:NSBundle,fileName: String) -> NSData{
        
        let path = bundle.pathForResource(fileName, ofType: "json")
        let jsonData = NSData(contentsOfMappedFile: path!)
        
        return jsonData!
    }
    
}
