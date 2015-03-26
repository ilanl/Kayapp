import Foundation

public class UserDao : NSObject,NSCoding{
    
    public private(set) var name: String
    public private(set) var pwd: String
    
    public init(name:String,pwd:String) {
        self.name = name
        self.pwd = pwd
    }
    
    public required init(coder: NSCoder) {
        self.name = coder.decodeObjectForKey("name") as String
        self.pwd = coder.decodeObjectForKey("pwd") as String
        super.init()
    }
    
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeObject(self.pwd, forKey: "pwd")
    }
}



