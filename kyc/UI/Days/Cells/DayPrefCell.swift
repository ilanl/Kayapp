import Foundation
import UIKit

class DayPrefCell: UITableViewCell {
    
    @IBOutlet weak var btnSurfSki: ToggleButton!
    @IBOutlet weak var btnKayak: ToggleButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func surfTap(sender: ToggleButton) {
        println("surf tapped \(sender.currentValue)")
    }
    
    @IBAction func kayakTap(sender: ToggleButton) {
        
        println("kayak tapped \(sender.currentValue)")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}