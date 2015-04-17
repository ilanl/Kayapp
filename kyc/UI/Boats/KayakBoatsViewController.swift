import UIKit

class KayakBoatsViewController: RankingBoatsViewController {

    override func boatFilter(boat: BoatDao)-> Bool{
        return boat.type == 2
    }
}
