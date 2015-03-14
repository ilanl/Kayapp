import Foundation

class UserRepository{

    class func get()->User?{
        return nil
    }
    
    class func save(user:User){
        Logger.log("user saved")
    }
}