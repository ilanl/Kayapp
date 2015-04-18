import Foundation

@objc public protocol UserRepositoryProtocol {
    func reset()->Bool
    
    func get() -> UserDao?
    
    func save(user: UserDao)->Bool
}

public class UserRepository:NSObject,UserRepositoryProtocol{
    
    let repository = Repository<UserDao>(plist: "User")
    
    public override required init(){
        println("initializing user singleton")
        super.init()
    }
    
    public func reset()->Bool{
        self.repository.reset()
        return true
    }
    
    public func get() -> UserDao?{
        if let user = self.repository.get().first{
            println("user: \(user.name) \(user.pwd)")
            return user
        }
        return nil
    }
    
    public func save(user: UserDao)->Bool{
        return self.repository.save([user])
    }
}

