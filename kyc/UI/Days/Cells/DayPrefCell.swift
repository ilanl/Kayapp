import Foundation
import UIKit

class DayPrefCell: UITableViewCell {
    
    @IBOutlet weak var btnSurfSki: DayPrefToggleButton!
    @IBOutlet weak var btnKayak: DayPrefToggleButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func surfTap(sender: DayPrefToggleButton) {
        println("surf tapped \(sender.currentValue)")
    }
    
    @IBAction func kayakTap(sender: DayPrefToggleButton) {
        
        println("kayak tapped \(sender.currentValue)")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}