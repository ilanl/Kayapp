import Foundation

public class PreferenceJson:NSObject, Serializable{
    public var isFrozen:Bool?
    public var set:SetJson
    public var reminder:Int?
    public var securityToken:String?
    public var status:String?
    public var error:String?
    
    required public init(dictionary: [NSObject : AnyObject]) {
        
        if let _frozen = dictionary["IsFrozen"] as? Bool{
            self.isFrozen = _frozen
        }
        
        self.set = SetJson(dictionary: dictionary)
        
        if let _reminder = dictionary["Reminder"] as? Int{
            self.reminder = _reminder
        }
        if let _securityToken = dictionary["SecurityToken"] as? String{
            self.securityToken = _securityToken
        }
        if let _status = dictionary["Status"] as? String{
            self.status = _status
        }
        if let _error = dictionary["error"] as? String{
            self.error = _error
        }
    }
}

public class KayakPrefJson:NSObject, Serializable{
    
    public var key: String?
    public var name: String?
    public var type: Int?
    public var weight: Int?
    
    required public init(dictionary: [NSObject : AnyObject]) {
        
        if let _key = dictionary["Key"] as? String{
            self.key = _key
        }
        if let _name = dictionary["Name"] as? String{
            self.name = _name
        }
        if let _type = dictionary["Type"] as? Int{
            self.type = _type
        }
        if let _weight = dictionary["Weight"] as? Int{
            self.weight = _weight
        }
    }
}

public class TimePrefJson:NSObject, Serializable{
    
    public var dayOfWeek:String?
    public var time:Int?
    public var type: Int?
    
    required public init(dictionary: [NSObject : AnyObject]) {
        
        if let _dayOfWeek = dictionary["DayOfWeek"] as? String{
            self.dayOfWeek = _dayOfWeek
        }
        if let _time = dictionary["Time"] as? Int{
            self.time = _time
        }
        if let _type = dictionary["Type"] as? Int{
            self.type = _type
        }
    }
}

public class SetJson:NSObject, Serializable{
    
    public var arrayOfKayakPrefs:[KayakPrefJson]
    public var arrayOfTimePrefs:[TimePrefJson]
    
    required public init(dictionary: [NSObject : AnyObject]) {
        
        let dict = dictionary["Set"] as [NSObject: AnyObject]
        self.arrayOfKayakPrefs = JsonParser.parseArrayToArrayOfType(dict["KayakPrefs"] as [AnyObject])
        
        self.arrayOfTimePrefs = JsonParser.parseArrayToArrayOfType(dict["TimePrefs"] as [AnyObject])
    }
}


