import Foundation

public class CoreComponents: TyphoonAssembly {
    
//    public dynamic func forecastService() -> AnyObject {
//        return TyphoonDefinition.withClass(ForecastService.self) {
//            (definition) in
//            //definition.injectProperty("serviceUrl", with:TyphoonConfig("service.url"))
//            definition.injectProperty("forecastDao", with:self.forecastDao())
//            definition.injectProperty("daysToRetrieve", with:TyphoonConfig("days.to.retrieve"))
//        }
//    }
    
    //MARK: - Services
    public dynamic func forecastServiceFactory() -> AnyObject {
        return TyphoonDefinition.withClass(ForecastService.self){
            (definition) in
            definition.injectProperty("forecastRepository", with: self.forecastRepositoryFactory())
        }
    }
    
    //MARK: - Repositories
    
    public dynamic func settingRepositoryFactory() -> AnyObject {
        return TyphoonDefinition.withClass(SettingRepository.self)
    }
    
    public dynamic func userRepositoryFactory() -> AnyObject {
        return TyphoonDefinition.withClass(UserRepository.self)
    }
    
    public dynamic func boatPrefsRepositoryFactory() -> AnyObject {
        return TyphoonDefinition.withClass(BoatPrefsRepository.self)
    }
    
    public dynamic func dayPrefsRepositoryFactory() -> AnyObject {
        return TyphoonDefinition.withClass(DayPrefsRepository.self)
    }
    
    public dynamic func forecastRepositoryFactory() -> AnyObject {
        return TyphoonDefinition.withClass(ForecastRepository.self)
    }
    
    public dynamic func boatsRepositoryFactory() -> AnyObject {
        return TyphoonDefinition.withClass(BoatsRepository.self)
    }
    
    public dynamic func bookingRepositoryFactory() -> AnyObject {
        return TyphoonDefinition.withClass(BookingRepository.self)
    }
}
