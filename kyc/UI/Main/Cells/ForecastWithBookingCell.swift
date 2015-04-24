import UIKit

class ForecastWithBookingCell: UITableViewCell {

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var waterTemp: UILabel!
    
    @IBOutlet weak var kayakNameLabel: UILabel!
    var forecast:ForecastDao?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(){
        self.tempLabel.text = "\(self.forecast!.booking!.boatName)"
    }

}
