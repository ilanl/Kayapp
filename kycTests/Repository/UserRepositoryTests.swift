import XCTest
import kyc

public class UserRepositoryTests: XCTestCase {
    var target : UserRepository!
    
    public override func setUp() {
        
        let factory = TyphoonBlockComponentFactory(assemblies: [CoreComponents()])
        self.target = factory.componentForKey("userRepositoryFactory") as? UserRepository
        self.target.reset()
    }
    
    public func test_get_and_save_user() {
        
        let name = "username"
        let pwd = "pwd"
        
        var user = UserDao(name:name, pwd:pwd)
        
        let savedResult = self.target.save(user)
        XCTAssertTrue(savedResult)
        
        var savedUser = self.target.get()!
        
        XCTAssertEqual(savedUser.name,name, "Incorrect user name")
        XCTAssertEqual(savedUser.pwd,pwd, "Incorrect user pwd")
    }
}
