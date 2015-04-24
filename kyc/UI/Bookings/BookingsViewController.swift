import UIKit

class BookingsViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate {

    var bookingsArray:[BookingDao]?
    let bookingRepository = coreComponents.componentForKey("bookingRepositoryFactory") as! BookingRepository
    
    @IBOutlet weak var exitButton: UIButton!
    @IBAction func didPressExit(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.bookingsArray = self.bookingRepository.get()
    }
    
    //MARK: Table delegates
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if self.bookingsArray == nil{
            return 0
        }
        return self.bookingsArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{

        let cell:BookingCell = tableView.dequeueReusableCellWithIdentifier("bookingCell", forIndexPath: indexPath) as! BookingCell
        
        let bookingDao:BookingDao = self.bookingsArray![indexPath.row]
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE dd MMM"
        let bookingDayTime = dateFormatter.stringFromDate(bookingDao.datetime!)
        
        cell.lblName.text = "\(bookingDayTime) \(bookingDao.boatName!) \(bookingDao.time!)"
        
        return cell
    }
}
