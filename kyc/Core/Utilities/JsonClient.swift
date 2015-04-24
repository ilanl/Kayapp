public class JsonClient:NSObject{

    class func get(url: NSURL,success:(NSData->Void)) {
        Logger.log("get url: \(url)")
        let request = NSURLRequest(URL: url)
        let urlSession = NSURLSession.sharedSession()
        let dataTask = urlSession.dataTaskWithRequest(request) {
            (var data, var response, var error) in
            if (error == nil) {
                 var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                Logger.log("Body: \(strData!)")
                success(data)
            } else {
                Logger.log("could not fetch data")
            }
        }
        
        dataTask.resume()
    }
    
    class func post(params : Dictionary<String, AnyObject>, url : String,success:(NSData->Void)) {
        Logger.log("post url: \(url)")
        var request = NSMutableURLRequest(URL: NSURL(string:url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            if (error == nil) {
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                Logger.log("Body: \(strData!)")
                success(data)
            } else {
                fatalError("could not fetch data")
            }
        })
        
        task.resume()
    }
}