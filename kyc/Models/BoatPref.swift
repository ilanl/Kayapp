//
//  BoatPref.swift
//  kyc
//
//  Created by Ilan Levy on 3/14/15.
//  Copyright (c) 2015 Ilan Levy. All rights reserved.
//

import Foundation
import CoreData

class BoatPref: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var order: NSNumber
    @NSManaged var boat_pref: Boat

}
