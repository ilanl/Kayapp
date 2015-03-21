import Foundation

class AuthenticateService{
    
    func authenticate(user: User, completion: ((LoginResponse) -> Void)?)
    {
        if let callback = completion?{
            Logger.log("authenticate callback")
            callback(LoginResponse())
        }
    }

}
    