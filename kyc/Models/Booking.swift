//
//  Booking.swift
//  kyc
//
//  Created by Ilan Levy on 3/14/15.
//  Copyright (c) 2015 Ilan Levy. All rights reserved.
//

import Foundation
import CoreData

class Booking: NSManagedObject {

    @NSManaged var datetime: NSDate
    @NSManaged var name: String
    @NSManaged var state: NSNumber

}
