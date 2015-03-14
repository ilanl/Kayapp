import UIKit

class MainViewController: CenterViewController {

    @IBAction func menuTapped(sender: AnyObject) {
        delegate?.toggleLeftPanel?()
    }
}

