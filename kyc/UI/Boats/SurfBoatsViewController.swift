import UIKit

class SurfBoatsViewController: RankingBoatsViewController {

    override func boatFilter(boat: BoatDao)-> Bool{
        return boat.type != 2
    }
    
}
