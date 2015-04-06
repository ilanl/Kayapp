import Foundation

public class CoreComponents: TyphoonAssembly {
    

    //MARK: - Services
    public dynamic func forecastServiceFactory() -> AnyObject {
        return TyphoonDefinition.withClass(ForecastService.self){
            (definition) in
            definition.injectProperty("forecastRepository", with: self.forecastRepositoryFactory())
        }
    }
    
    public dynamic func preferenceServiceFactory() -> AnyObject {
        return TyphoonDefinition.withClass(PreferenceService.self){
            (definition) in
            definition.injectProperty("boatsRepository", with: self.boatsRepositoryFactory())
            definition.injectProperty("boatPrefsRepository", with: self.boatPrefsRepositoryFactory())
            definition.injectProperty("dayPrefsRepository", with: self.dayPrefsRepositoryFactory())
            definition.injectProperty("userRepository", with: self.userRepositoryFactory())
            definition.injectProperty("settingRepository", with: self.settingRepositoryFactory())
        }
    }
    
    public dynamic func bookingServiceFactory() -> AnyObject {
        return TyphoonDefinition.withClass(BookingService.self){
            (definition) in
            definition.injectProperty("bookingRepository", with: self.bookingRepositoryFactory())
            definition.injectProperty("userRepository", with: self.userRepositoryFactory())
        }
    }

    public dynamic func forecastAndBookingMatcherFactory() -> AnyObject {
        return TyphoonDefinition.withClass(ForecastAndBookingMatcher.self){
            (definition) in
            definition.injectProperty("forecastRepository", with: self.forecastRepositoryFactory())
            definition.injectProperty("bookingRepository", with: self.bookingRepositoryFactory())
        }
    }

    
    //MARK: - Repositories
    
    public dynamic func settingRepositoryFactory() -> AnyObject {
        return TyphoonDefinition.withClass(SettingRepository.self){(definition) in
            definition.scope = TyphoonScope.Singleton
        }
    }
    
    public dynamic func userRepositoryFactory() -> AnyObject {
        return TyphoonDefinition.withClass(UserRepository.self){(definition) in
            definition.scope = TyphoonScope.Singleton
        }
    }
    
    public dynamic func boatPrefsRepositoryFactory() -> AnyObject {
        return TyphoonDefinition.withClass(BoatPrefsRepository.self){(definition) in
            definition.scope = TyphoonScope.Singleton
        }
    }
    
    public dynamic func dayPrefsRepositoryFactory() -> AnyObject {
        return TyphoonDefinition.withClass(DayPrefsRepository.self){(definition) in
            definition.scope = TyphoonScope.Singleton
        }
    }
    
    public dynamic func forecastRepositoryFactory() -> AnyObject {
        return TyphoonDefinition.withClass(ForecastRepository.self){(definition) in
            definition.scope = TyphoonScope.Singleton
        }
    }
    
    public dynamic func boatsRepositoryFactory() -> AnyObject {
        return TyphoonDefinition.withClass(BoatsRepository.self){(definition) in
            definition.scope = TyphoonScope.Singleton
        }
    }
    
    public dynamic func bookingRepositoryFactory() -> AnyObject {
        return TyphoonDefinition.withClass(BookingRepository.self){(definition) in
            definition.scope = TyphoonScope.Singleton
        }
    }
    
}
