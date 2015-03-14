//
//  Setting.swift
//  kyc
//
//  Created by Ilan Levy on 3/14/15.
//  Copyright (c) 2015 Ilan Levy. All rights reserved.
//

import Foundation
import CoreData

class Setting: NSManagedObject {

    @NSManaged var mode: NSNumber
    @NSManaged var reminder: NSNumber

}
