import UIKit

class SettingsViewController: UIViewController {

    @IBAction func didPressExit(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var exitButton: UIButton!
}
