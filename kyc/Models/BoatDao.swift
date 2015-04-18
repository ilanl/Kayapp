import Foundation

public class BoatDao: NSObject,NSCoding,Equatable{
    
    public var name:String?
    public var type:Int?
    public var id:String?
    
    public init(id:String?,name:String?,type:Int?) {
        self.name = name
        self.type = type
        self.id = id
    }
    
    public required init(coder: NSCoder) {
        self.id = coder.decodeObjectForKey("id") as? String
        self.name = coder.decodeObjectForKey("date") as? String
        self.type = coder.decodeObjectForKey("type") as? Int
        super.init()
    }
    
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.id, forKey: "id")
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeObject(self.type, forKey: "type")
    }
}

public func ==(lhs: BoatDao, rhs: BoatDao) -> Bool{
    return lhs.name == rhs.name && lhs.id == rhs.id
}
