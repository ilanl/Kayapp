import Foundation

let SyncData = "com.breezback.kyc.syncData"
let NewBooking = "com.breezback.kyc.newBooking"
let FetchWeather = "com.breezback.kyc.fetchWeather"

private let ManagerSharedInstance = Manager()

class Manager:NSObject {

    class var sharedInstance: Manager {
        return ManagerSharedInstance
    }
    
    var userName:String?
    var passWord:String?
    
    var isAuthenticated: Bool{
        get{
            return userName != nil
        }
    }
    
    func authenticate(user: String, pwd: String, completion: ((LoginResponse) -> Void)?)
    {
        self.userName = user
        self.passWord = pwd
        
        if let callback = completion?{
            Logger.log("authenticate callback")
            callback(LoginResponse())
        }
    }
    
    
}




