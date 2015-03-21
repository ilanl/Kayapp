import UIKit

class SurfBoatsViewController: RankingBoatsViewController {

    @IBAction func didPressClose(sender: UIButton) {
        super.didPressCloseButton(sender)
    }
    
    @IBOutlet weak var closeButton: UIButton!
}
