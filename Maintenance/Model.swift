//
//  Model.swift
//  Maintenance
//
//  Created by Marcus Shannon on 5/8/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit
import CoreData

enum Entity: String {
    case Worker = "Worker"
    case ServiceRequest = "ServiceRequest"
}

protocol DataModel {
    
    func countEntity(entity: Entity) -> Int
    
    func newEntity(entity: Entity)
    
    func save()
    
    func fetchEntity(entity: Entity) -> [NSManagedObject]
    
    func deleteEntity(entity: Entity)
    
    func getObject(entity: Entity) -> NSManagedObject
}

class Model: DataModel {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var moc: NSManagedObjectContext!
    
    init() {
        self.moc = appDelegate.dataController.managedObjectContext
    }
    
    func countEntity(entity: Entity) -> Int {
        return self.moc.countForFetchRequest(NSFetchRequest(entityName: entity.rawValue), error: nil)
    }
    
    func newEntity(entity: Entity) {
        NSEntityDescription.insertNewObjectForEntityForName(entity.rawValue, inManagedObjectContext: self.moc)
        self.save()
    }
    
    func fetchEntity(entity: Entity) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest(entityName: entity.rawValue)
        do {
            let fetched = try self.moc.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            return fetched
        } catch {
            fatalError()
        }
    }
    
    func deleteEntity(entity: Entity) {
        for object in self.fetchEntity(entity) {
            self.moc.deleteObject(object)
        }
        self.save()
    }
    
    func getObject(entity: Entity) -> NSManagedObject {
        if self.countEntity(entity) > 0 {
            return self.fetchEntity(entity)[0]
        }
        return NSManagedObject()
    }
    
    
    func save() {
        do {
            try self.moc.save()
        }
        catch {
            
        }
    }
}