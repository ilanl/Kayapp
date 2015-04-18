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
    var configReader:ConfigReader?
    
    public init(boatsRepository:BoatsRepository,boatPrefsRepository:BoatPrefsRepository,dayPrefsRepository:DayPrefsRepository,userRepository:UserRepository, settingRepository:SettingRepository,configReader:ConfigReader) {
        self.boatsRepository = boatsRepository
        self.boatPrefsRepository = boatPrefsRepository
        self.userRepository = userRepository
        self.settingRepository = settingRepository
        self.dayPrefsRepository = dayPrefsRepository
        self.configReader = configReader
    }
    
    public func savePreferences(successBlock: (([BoatDao]?,[BoatPrefDao]?,[DayPrefDao]?,SettingDao?) -> Void)?, onError errorBlock: ((String) -> Void)?)
    {
        let url = self.configReader!.savePreferenceUrl
        
        let userDao = self.userRepository!.get()
        if userDao == nil || userDao!.isAnonymous(){
            errorBlock!("can not fetch preferences as anonymous")
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
        let url = self.configReader!.getPreferenceUrl
        
        let userDao:UserDao? = self.userRepository!.get()
        
        if userDao == nil || userDao!.isAnonymous(){
            errorBlock!("can not save preferences as anonymous")
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
            boatsDaos.append(BoatDao(id: b.key!,name: b.name!, type: b.type!))
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
        let dayPrefsToSave = self.dayPrefsRepository!.get()
        println("dayPrefs: found \(dayPrefsToSave.count)")
        
        var timePrefs = [[NSObject : AnyObject]]()
        for e in dayPrefsToSave{
            var dayPrefDict = [NSObject : AnyObject]()
            dayPrefDict["Time"] = e.time
            dayPrefDict["DayOfWeek"] = Day.getDayNameByInt(e.day)
            dayPrefDict["Type"] = e.type
            timePrefs.append(dayPrefDict)
        }
        setDict["TimePrefs"] = timePrefs
        
        let boatPrefsToSave = self.boatPrefsRepository!.get()
        println("boatPrefs: found \(boatPrefsToSave.count)")

        var boatPrefs = [[NSObject : AnyObject]]()
        for e in boatPrefsToSave{
            var boat = self.boatsRepository!.getBoatByName(e.name)!
            var boatPrefDict = [NSObject : AnyObject]()
            boatPrefDict["Key"] = boat.id
            boatPrefDict["Name"] = e.name
            boatPrefDict["Weight"] = e.order
            boatPrefDict["Type"] = boat.type
            boatPrefs.append(boatPrefDict)
        }
        setDict["KayakPrefs"] = boatPrefs
        
        var error:NSError?
        var data = NSJSONSerialization.dataWithJSONObject(setDict, options:NSJSONWritingOptions(0), error: &error)
        println("data json: \(data)")
        return setDict
    }
}