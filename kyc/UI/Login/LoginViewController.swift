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
        
        userRepository.save(UserDao(name: self.txtUser.text, pwd: self.txtPwd.text))
        
        NSNotificationCenter.defaultCenter().postNotificationName(fireLoadDataNotificationKey, object: self)
    }
    
    func afterLoadData(){
        
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
}
