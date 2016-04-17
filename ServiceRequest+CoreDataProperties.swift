//
//  ServiceRequest+CoreDataProperties.swift
//  Maintenance
//
//  Created by Marcus Shannon on 4/9/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ServiceRequest {

    @NSManaged var taskStart: NSDate?
    @NSManaged var taskEnd: NSDate?
    @NSManaged var travelStart: NSDate?
    @NSManaged var travelEnd: NSDate?
    @NSManaged var location: String?
    @NSManaged var taskDescription: String?
    @NSManaged var srNumber: String?
    @NSManaged var inProgress: NSNumber?

}
