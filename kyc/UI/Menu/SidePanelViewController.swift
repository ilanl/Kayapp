import UIKit

@objc
protocol SidePanelViewControllerDelegate {
  func menuItemSelected(menuItem: MenuItem)
}

class SidePanelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  @IBOutlet weak var tableView: UITableView!

  var delegate: SidePanelViewControllerDelegate?
  var menuItems: Array<MenuItem>!

  struct TableView {
    struct CellIdentifiers {
      static let MenuItemCell = "MenuItemCell"
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView(frame: CGRect.zeroRect)
    tableView.reloadData()
  }

  // MARK: Table View Data Source

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuItems.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(TableView.CellIdentifiers.MenuItemCell, forIndexPath: indexPath) as MenuItemCell
    cell.configureForMenuItem(menuItems[indexPath.row])
    return cell
  }

  // Mark: Table View Delegate
  func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
    let selectedMenuItem = menuItems[indexPath.row]
    delegate?.menuItemSelected(selectedMenuItem)
  }

}

class MenuItemCell: UITableViewCell {
  @IBOutlet weak var menuItemImage: UIImageView!
  @IBOutlet weak var menuItemTitle: UILabel!

  func configureForMenuItem(menuItem: MenuItem) {
    if ((menuItem.image as UIImage?) != nil){
        menuItemImage.image = menuItem.image
    }
    menuItemTitle.text = menuItem.title
  }
}