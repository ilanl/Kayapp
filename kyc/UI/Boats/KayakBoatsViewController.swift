import UIKit

class KayakBoatsViewController: RankingBoatsViewController {

    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func didPressClose(sender: UIButton) {
        super.didPressCloseButton(sender)
    }
}
