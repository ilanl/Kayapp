import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "afterLoadData", name: doneLoadDataNotificationKey, object: nil)
    }
    
    @IBOutlet weak var txtUser: UITextField!
    
    @IBOutlet weak var txtPwd: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBAction func didPressLogin(sender: UIButton) {
        
        let userRepository = coreComponents.componentForKey("userRepositoryFactory") as UserRepository
        var user = UserDao(name: self.txtUser.text, pwd: self.txtPwd.text)
        user.deviceToken = "213132313"
        userRepository.save(user)
        
        NSNotificationCenter.defaultCenter().postNotificationName(fireLoadDataNotificationKey, object: self)
    }
    
    func afterLoadData(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
