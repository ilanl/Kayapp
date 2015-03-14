import Foundation

let SyncData = "com.breezback.kyc.syncData"
let NewBooking = "com.breezback.kyc.newBooking"
let FetchWeather = "com.breezback.kyc.fetchWeather"

private let ManagerSharedInstance = Manager()

class Manager:NSObject {

    class var sharedInstance: Manager {
        return ManagerSharedInstance
    }
    
    var user:User?
    
    var isAuthenticated: Bool{
        get{
            return user != nil
        }
    }
    
    func authenticate(user: User, completion: ((LoginResponse) -> Void)?)
    {
        if let callback = completion?{
            Logger.log("authenticate callback")
            callback(LoginResponse())
        }
    }
    
    
}




