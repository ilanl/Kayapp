//
//  Forecast.swift
//  kyc
//
//  Created by Ilan Levy on 3/14/15.
//  Copyright (c) 2015 Ilan Levy. All rights reserved.
//

import Foundation
import CoreData

class Forecast: NSManagedObject {

    @NSManaged var datetime: NSDate
    @NSManaged var weather: NSNumber
    @NSManaged var waterTemp: NSNumber
    @NSManaged var temp: NSNumber
    @NSManaged var waveHeight: NSNumber
    
    var booking: Booking?

}
