import Foundation

public class CoreComponents: TyphoonAssembly {
    
    //MARK: - Configuration
    
    public dynamic func configReaderFactory() -> AnyObject {
        return TyphoonDefinition.withClass(ConfigReader.self){(definition) in
            definition.scope = TyphoonScope.Singleton
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
    
    public dynamic func forecastRepositoryFactory() -> AnyObject {
        return TyphoonDefinition.withClass(ForecastRepository.self){(definition) in
            definition.scope = TyphoonScope.Singleton
        }
    }
    
    //MARK: - Services
    public dynamic func forecastServiceFactory() -> AnyObject {
        
        return TyphoonDefinition.withClass(ForecastService.self) {
            (definition) in
            definition.useInitializer("initWithForecastRepository:configReader:") {
                (initializer) in
                initializer.injectParameterWith(self.forecastRepositoryFactory())
                initializer.injectParameterWith(self.configReaderFactory())
            }
        }
    }
    
    public dynamic func preferenceServiceFactory() -> AnyObject {
        return TyphoonDefinition.withClass(PreferenceService.self){
            (definition) in
            definition.useInitializer("initWithBoatsRepository:boatPrefsRepository:dayPrefsRepository:userRepository:settingRepository:configReader:") {
                (initializer) in
                initializer.injectParameterWith(self.boatsRepositoryFactory())
                initializer.injectParameterWith(self.boatPrefsRepositoryFactory())
                initializer.injectParameterWith(self.dayPrefsRepositoryFactory())
                initializer.injectParameterWith(self.userRepositoryFactory())
                initializer.injectParameterWith(self.settingRepositoryFactory())
                initializer.injectParameterWith(self.configReaderFactory())
            }
        }
    }

    public dynamic func bookingServiceFactory() -> AnyObject {
        return TyphoonDefinition.withClass(BookingService.self){
            (definition) in
            definition.useInitializer("initWithBookingRepository:userRepository:configReader:") {
                (initializer) in
                initializer.injectParameterWith(self.bookingRepositoryFactory())
                initializer.injectParameterWith(self.userRepositoryFactory())
                initializer.injectParameterWith(self.configReaderFactory())
            }
        }
    }

    public dynamic func forecastAndBookingMatcherFactory() -> AnyObject {
        return TyphoonDefinition.withClass(ForecastAndBookingMatcher.self){
            (definition) in
            definition.scope = TyphoonScope.Singleton
            definition.useInitializer("initWithForecastRepository:bookingRepository:") {
                (initializer) in
                initializer.injectParameterWith(self.forecastRepositoryFactory())
                initializer.injectParameterWith(self.bookingRepositoryFactory())
                
            }
        }
    }
}
