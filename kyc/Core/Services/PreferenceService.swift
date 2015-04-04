import Foundation

@objc public protocol PreferenceServiceProtocol {
    
    func getPreferences(successBlock: (([BoatDao]?,[BoatPrefDao]?,[DayPrefDao]?,SettingDao?) -> Void)?, onError errorBlock: ((String) -> Void)?)
}

public class PreferenceService: NSObject, PreferenceServiceProtocol {
    
    var boatsRepository:BoatsRepository
    var boatPrefsRepository:BoatPrefsRepository
    var dayPrefsRepository:DayPrefsRepository
    var userRepository:UserRepository
    var settingRepository:SettingRepository
    
    public init(boatsRepo:BoatsRepository,boatPrefRepo:BoatPrefsRepository,dayPrefsRepo:DayPrefsRepository,userRepo:UserRepository, settingRepo:SettingRepository) {
        self.boatsRepository = boatsRepo
        self.boatPrefsRepository = boatPrefRepo
        self.userRepository = userRepo
        self.settingRepository = settingRepo
        self.dayPrefsRepository = dayPrefsRepo
    }
    
    public func getPreferences(successBlock: (([BoatDao]?,[BoatPrefDao]?,[DayPrefDao]?,SettingDao?) -> Void)?, onError errorBlock: ((String) -> Void)?)
    {
        let url = "http://breezback.com/IKayak/preferences.ashx"
        
        //{"SecurityToken":null,"IsFrozen":null,"UserName":"%D7%90%D7%99%D7%9C%D7%9F%20%D7%9C","Action":"0","Set":null,"Reminder":0,"DeviceToken":"7851dc5ce47f31105238767b8e45614789bb46542e4b251fb7b685982dbc4e47","Password":"32371"}
        
        let userDao = self.userRepository.get()
        if userDao == nil || userDao!.isAnonymous(){
            fatalError("can not fetch preferences as anonymous")
        }
        
        JsonClient.post(["UserName":userDao!.name, "Password":userDao!.pwd, "DeviceToken":userDao!.deviceToken!], url: url){ (data:NSData) -> Void in
            
            let preferences = PreferenceParser.parseJson(data)
            
            if preferences.status!.lowercaseString != "success"
            {
                fatalError("could not fetch boat preferences")
            }
            
            var boatsDaos = [BoatDao]()
            var boatPrefsDaos = [BoatPrefDao]()

            for b in preferences.set.arrayOfKayakPrefs
            {
                boatsDaos.append(BoatDao(name: b.name!, type: b.type!))
                if b.weight != nil && b.weight! > 0
                {
                    boatPrefsDaos.append(BoatPrefDao(name: b.name!, order: b.weight!))
                }
            }
            self.boatsRepository.save(boatsDaos)
            self.boatPrefsRepository.save(boatPrefsDaos)

            var dayPrefDaos = [DayPrefDao]()
            for b in preferences.set.arrayOfTimePrefs
            {
                dayPrefDaos.append(DayPrefDao(day: Day.getDayByString(b.dayOfWeek!), time: b.time!, type: b.type!))
            }
            self.dayPrefsRepository.save(dayPrefDaos)
            
            var settingDao = SettingDao(mode: preferences.isFrozen! ? 0 : 1, reminder:  preferences.reminder!)
            self.settingRepository.save(settingDao)
            
            successBlock!(boatsDaos,boatPrefsDaos,dayPrefDaos,settingDao)
        }
    }
}