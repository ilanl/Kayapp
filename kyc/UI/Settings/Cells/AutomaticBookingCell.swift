import Foundation
import UIKit

class AutomaticBookingCell: UITableViewCell {
    
    @IBOutlet weak var swAutomaticBooking: UISwitch!
    @IBOutlet weak var lblAutomaticBooking: UILabel!
    
    var settingRepository:SettingRepository?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.updateUI()
    }
    
    func updateUI(){
        if let settingDao = self.settingRepository?.get(){
            
            println("read automatic-booking mode: \(settingDao.mode)")
            
            self.swAutomaticBooking.on = settingDao.mode == 1 ? true : false
        }
        
    }
    
    @IBAction func swAutomaticBooking(sender: UISwitch) {
        
        var settingDao: SettingDao? = self.settingRepository?.get()
        if (settingDao != nil) {
            settingDao!.mode = sender.on == true ? 1 : 0
        }
        else{
            settingDao = SettingDao(mode: sender.on ? 1 : 0, reminder: nil)
        }
        self.settingRepository!.save(settingDao!)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
