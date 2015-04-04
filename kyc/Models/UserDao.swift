import Foundation

public class UserDao : NSObject,NSCoding{
    
    public private(set) var name: String
    public private(set) var pwd: String
    public var deviceToken: String?
    public var securityToken: String?
    
    public init(name:String,pwd:String) {
        self.name = name
        self.pwd = pwd
    }
    
    public required init(coder: NSCoder) {
        self.name = coder.decodeObjectForKey("name") as String
        self.pwd = coder.decodeObjectForKey("pwd") as String
        self.deviceToken = coder.decodeObjectForKey("deviceToken") as String?
        self.securityToken = coder.decodeObjectForKey("securityToken") as String?
        
        super.init()
    }
    
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeObject(self.pwd, forKey: "pwd")
        coder.encodeObject(self.deviceToken, forKey: "deviceToken")
        coder.encodeObject(self.securityToken, forKey: "securityToken")
    }
    
    public func isAnonymous()-> Bool{
        return (self.name.isEmpty || self.pwd.isEmpty || self.deviceToken == nil)
    }
}



