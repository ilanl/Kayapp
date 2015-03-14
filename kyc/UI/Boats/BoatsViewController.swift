import UIKit

class BoatsViewController: UIViewController {

    @IBOutlet weak var exitButton: UIButton!
    @IBAction func didPressExit(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
