import Foundation
import UIKit

class ForecastWithNoBookingCell: UITableViewCell {
    
    @IBOutlet weak var hourLabel: UILabel!
    var forecast:ForecastDao?
    @IBOutlet weak var waveHeightLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

