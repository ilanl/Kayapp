import Foundation
import UIKit

class BoatRankCell: UITableViewCell {
    
    @IBOutlet weak var btnOrder: ToggleButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func orderTap(sender: ToggleButton) {
        println("order tapped \(sender.currentValue)")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}