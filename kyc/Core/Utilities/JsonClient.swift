public class JsonClient:NSObject{

    class func fetchData(url: NSURL,success:(NSData->Void)) {
        let request = NSURLRequest(URL: url)
        let urlSession = NSURLSession.sharedSession()
        let dataTask = urlSession.dataTaskWithRequest(request) {
            (var data, var response, var error) in
            if (error == nil) {
                success(data)
            } else {
                fatalError("could not fetch data")
            }
        }
        dataTask.resume()
    }
}