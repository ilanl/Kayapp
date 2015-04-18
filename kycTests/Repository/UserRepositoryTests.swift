import XCTest
import kyc

public class UserRepositoryTests: XCTestCase {
    var target : UserRepository!
    
    public override func setUp() {
        
        self.target = UserRepository()
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
    
    public override func tearDown() {
        self.target.reset()
    }
}
