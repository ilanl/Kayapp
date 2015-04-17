import Foundation

@objc public protocol PreferenceServiceProtocol {
    
    func savePreferences(successBlock: (([BoatDao]?,[BoatPrefDao]?,[DayPrefDao]?,SettingDao?) -> Void)?, onError errorBlock: ((String) -> Void)?)
    
    func getPreferences(successBlock: (([BoatDao]?,[BoatPrefDao]?,[DayPrefDao]?,SettingDao?) -> Void)?, onError errorBlock: ((String) -> Void)?)
}

public class PreferenceService:NSObject,PreferenceServiceProtocol {
    
    var boatsRepository:BoatsRepository?
    var boatPrefsRepository:BoatPrefsRepository?
    var dayPrefsRepository:DayPrefsRepository?
    var userRepository:UserRepository?
    var settingRepository:SettingRepository?
    
    public init(boatsRepository:BoatsRepository,boatPrefsRepository:BoatPrefsRepository,dayPrefsRepository:DayPrefsRepository,userRepository:UserRepository, settingRepository:SettingRepository) {
        self.boatsRepository = boatsRepository
        self.boatPrefsRepository = boatPrefsRepository
        self.userRepository = userRepository
        self.settingRepository = settingRepository
        self.dayPrefsRepository = dayPrefsRepository
    }
    
    public func savePreferences(successBlock: (([BoatDao]?,[BoatPrefDao]?,[DayPrefDao]?,SettingDao?) -> Void)?, onError errorBlock: ((String) -> Void)?)
    {
        let url = "http://breezback.com/IKayak/preferences.ashx"
        
        let userDao = self.userRepository!.get()
        if userDao == nil || userDao!.isAnonymous(){
            errorBlock!("can not fetch preferences as! anonymous")
            return
        }
        let set: AnyObject = self.read()
        let settingDao = self.settingRepository!.get()
        
        JsonClient.post(["UserName":userDao!.name,"Password":userDao!.pwd,"Action":"1","IsFrozen": settingDao?.mode == 1 ? "1" : "" ,"Reminder":"\(settingDao!.reminder!)","DeviceToken":userDao!.deviceToken!, "Set": set], url: url){ (data:NSData) -> Void in
            
            let preferences = PreferenceParser.parseJson(data)
            
            if preferences.status!.lowercaseString != "success"
            {
                errorBlock!("could not save preferences")
                return
            }
            
            //never save the result of the save response
            successBlock!(nil,nil,nil,nil)
        }
    }
    
    public func getPreferences(successBlock: (([BoatDao]?,[BoatPrefDao]?,[DayPrefDao]?,SettingDao?) -> Void)?, onError errorBlock: ((String) -> Void)?)
    {
        let url = "http://breezback.com/IKayak/preferences.ashx"
        
        let userDao:UserDao? = self.userRepository!.get()
        if userDao == nil || userDao!.isAnonymous(){
            errorBlock!("can not fetch preferences as! anonymous")
            return
        }
        let deviceToken:String = (userDao!.deviceToken == nil) ? "" : userDao!.deviceToken!
        
        JsonClient.post(["UserName":userDao!.name, "Password":userDao!.pwd, "DeviceToken":deviceToken], url: url){ (data:NSData) -> Void in
            
            let preferences = PreferenceParser.parseJson(data)
            
            if preferences.status!.lowercaseString != "success"
            {
                errorBlock!("could not fetch preferences")
                return
            }
            
            self.persist(preferences, successBlock: successBlock)
        }
    }
    
    private func persist(preferences:PreferenceJson, successBlock: (([BoatDao]?,[BoatPrefDao]?,[DayPrefDao]?,SettingDao?) -> Void)?){
        
        var boatsDaos = [BoatDao]()
        var boatPrefsDaos = [BoatPrefDao]()
        
        for b in preferences.set.arrayOfKayakPrefs
        {
            println("boat: \(b.name!) \(b.type!)")
            
            boatsDaos.append(BoatDao(name: b.name!, type: b.type!))
            if b.weight != nil && b.weight! > 0
            {
                boatPrefsDaos.append(BoatPrefDao(name: b.name!, order: b.weight!))
            }
        }
        self.boatsRepository!.save(boatsDaos)
        self.boatPrefsRepository!.save(boatPrefsDaos)
        
        var dayPrefDaos = [DayPrefDao]()
        for b in preferences.set.arrayOfTimePrefs
        {
            dayPrefDaos.append(DayPrefDao(day: Day.getDayByString(b.dayOfWeek!), time: b.time!, type: b.type!))
        }
        self.dayPrefsRepository!.save(dayPrefDaos)
        
        var settingDao = SettingDao(mode: preferences.isFrozen! ? 0 : 1, reminder:  preferences.reminder!)
        self.settingRepository!.save(settingDao)
        
        successBlock!(boatsDaos,boatPrefsDaos,dayPrefDaos,settingDao)
    }
    
    private func read()->AnyObject{
        
        var setDict = [NSObject : AnyObject]()

        //TODO - replace with real code
        var timePrefs = [[NSObject : AnyObject]]()
        for e in self.dayPrefsRepository!.get(){
            var obj = [NSObject : AnyObject]()
            obj["Time"] = 0
            obj["DayOfWeek"] = "Sunday"
            obj["Type"] = 2
            timePrefs.append(obj)
        }
        setDict["TimePrefs"] = timePrefs
        
        var boatPrefs = [[NSObject : AnyObject]]()
        for e in self.boatPrefsRepository!.get(){
            var obj = [NSObject : AnyObject]()
            obj["Key"] = "2"
            obj["Name"] = "קיאק 02"
            obj["Weight"] = 3
            obj["Type"] = 2
            boatPrefs.append(obj)
        }
        setDict["KayakPrefs"] = boatPrefs
        
        var error:NSError?
        var data = NSJSONSerialization.dataWithJSONObject(setDict, options:NSJSONWritingOptions(0), error: &error)
        
        return setDict
    }
}