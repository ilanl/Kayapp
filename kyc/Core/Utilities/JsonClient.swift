class JsonClient:NSObject{

    func getList<T: Serializable>(url: NSURL, completion:([T])->Void) {
        var parsedList = [T]()
        let request = NSURLRequest(URL: url)
        let urlSession = NSURLSession.sharedSession()
        let dataTask = urlSession.dataTaskWithRequest(request) {
            (var data, var response, var error) in
            if (error != nil) {
                var parseError : NSError?
                let unparsedArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &parseError) as [AnyObject]
                parsedList = JsonParser.parseArrayToArrayOfType(unparsedArray)
            } else {
                println(error)
            }
            // call the completion function (on the main thread)
            dispatch_async(dispatch_get_main_queue()) {
                completion(parsedList)
            }
        }
        dataTask.resume()
    }
}