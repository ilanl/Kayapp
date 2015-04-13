import Foundation

public class BoatPrefDao : NSObject,NSCoding{
    
    public private(set) var name: String
    public private(set) var order: Int
    
    public init(name:String,order:Int) {
        self.name = name
        self.order = order
    }
    
    public required init(coder: NSCoder) {
        self.name = coder.decodeObjectForKey("name") as! String
        self.order = coder.decodeObjectForKey("order")as! Int
        super.init()
    }
    
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeObject(self.order, forKey: "order")
    }
}
