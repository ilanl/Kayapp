//
//  DayPref.swift
//  kyc
//
//  Created by Ilan Levy on 3/14/15.
//  Copyright (c) 2015 Ilan Levy. All rights reserved.
//

import Foundation
import CoreData

class DayPref: NSManagedObject {

    @NSManaged var day: NSNumber
    @NSManaged var time: NSNumber
    @NSManaged var boatType: NSNumber

}
