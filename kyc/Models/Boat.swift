//
//  Boat.swift
//  kyc
//
//  Created by Ilan Levy on 3/14/15.
//  Copyright (c) 2015 Ilan Levy. All rights reserved.
//

import Foundation
import CoreData

class Boat: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var boatType: NSNumber
    @NSManaged var boat_pref: BoatPref

}
