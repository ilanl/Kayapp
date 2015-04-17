import Foundation

public enum BoatType: Int, Equatable {
    case KAYAK = 1
    case SURFSKI = 2
}

public class BoatDao: NSObject,NSCoding,Equatable{
    
    public var name:String?
    public var type:Int?
    
    public var boatType:BoatType{
       let t = self.type!
       return BoatType(rawValue: t)!
    }
    
    public init(name:String?,type:Int?) {
        self.name = name
        self.type = type
    }
    
    public required init(coder: NSCoder) {
        self.name = coder.decodeObjectForKey("date") as? String
        self.type = coder.decodeObjectForKey("type") as? Int
        super.init()
    }
    
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeObject(self.type, forKey: "type")
    }
}

public func ==(lhs: BoatDao, rhs: BoatDao) -> Bool{
    return lhs.name == rhs.name
}
