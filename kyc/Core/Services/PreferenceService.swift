import Foundation

@objc public protocol PreferenceServiceProtocol {
    
    func getPreferences(successBlock: (([BoatDao]?,[BoatPrefDao]?,[DayPrefDao]?,UserDao?) -> Void)?, onError errorBlock: ((String) -> Void)?)
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
    
    public func getPreferences(successBlock: (([BoatDao]?,[BoatPrefDao]?,[DayPrefDao]?,UserDao?) -> Void)?, onError errorBlock: ((String) -> Void)?)
    {
        let url = "http://breezback.com/IKayak/preferences.ashx"
        
        //{"SecurityToken":null,"IsFrozen":null,"UserName":"%D7%90%D7%99%D7%9C%D7%9F%20%D7%9C","Action":"0","Set":null,"Reminder":0,"DeviceToken":"7851dc5ce47f31105238767b8e45614789bb46542e4b251fb7b685982dbc4e47","Password":"32371"}
        
        JsonClient.post(["UserName":"%D7%90%D7%99%D7%9C%D7%9F", "Password":"32371", "DeviceToken":"7851dc5ce47f31105238767b8e45614789bb46542e4b251fb7b685982dbc4e47"], url: url){ (data:NSData) -> Void in
            
            let preferences = PreferenceParser.parseJson(data)
            
            if preferences.set.arrayOfKayakPrefs.count == 0
            {
                fatalError("could not fetch boat preferences")
            }
            
            successBlock!([BoatDao(name: "Some", type: 1)],nil,nil,nil)
        }
    }
}