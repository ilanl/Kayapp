import UIKit

@objc
class MenuItem {
    
    let title: String
    let tag: String
    let image: UIImage?
 
    init(title: String,image: UIImage?, tag:String) {
        self.title = title
        self.image = image
        self.tag = tag
    }
    
    class func allMenus() -> Array<MenuItem> {
        return [ MenuItem(title: "Days", image: nil,tag: "Days"),
            MenuItem(title: "Boats", image: nil, tag: "Boats"),
            MenuItem(title: "Bookings",  image: nil, tag: "Bookings"),
            MenuItem(title: "Settings",  image: nil, tag: "Settings")
                ]
    }
}