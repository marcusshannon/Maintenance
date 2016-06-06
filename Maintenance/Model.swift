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
    case Worker, ServiceRequest, CurrentStage
}

enum Stage: String {
    case Worker, Menu, ServiceRequestNumber, Location, Travel, StartTravel, StartTask
}

protocol DataModel {
    
    func countEntity(entity: Entity) -> Int
    
    func insertNewEntity(entity: Entity) -> NSManagedObject
    
    func save()
    
    func fetchEntity(entity: Entity) -> [NSManagedObject]
    
    func deleteEntity(entity: Entity)
    
    var serviceRequest: ServiceRequest! { get }
    
    var worker: Worker! { get }
    
    var currentStage: CurrentStage! { get }
    
}

class Model: DataModel {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var moc: NSManagedObjectContext!
    var serviceRequest: ServiceRequest!
    var worker: Worker!
    var currentStage: CurrentStage!
    
    init() {
        self.moc = appDelegate.dataController.managedObjectContext
        if self.countEntity(Entity.ServiceRequest) == 0 {
            self.serviceRequest = self.insertNewEntity(Entity.ServiceRequest) as! ServiceRequest
        }
        else {
            self.serviceRequest = self.fetchEntity(Entity.ServiceRequest)[0] as! ServiceRequest
        }
        if self.countEntity(Entity.Worker) == 0 {
            self.worker = self.insertNewEntity(Entity.Worker) as! Worker
        }
        else {
            self.worker = self.fetchEntity(Entity.Worker)[0] as! Worker
        }
    }
    
    func countEntity(entity: Entity) -> Int {
        return self.moc.countForFetchRequest(NSFetchRequest(entityName: entity.rawValue), error: nil)
    }
    
    func insertNewEntity(entity: Entity) -> NSManagedObject {
        return NSEntityDescription.insertNewObjectForEntityForName(entity.rawValue, inManagedObjectContext: self.moc)
    }
    
    func fetchEntity(entity: Entity) -> [NSManagedObject] {
        do {
            let fetched = try self.moc.executeFetchRequest(NSFetchRequest(entityName: entity.rawValue)) as! [NSManagedObject]
            return fetched
        } catch {
            fatalError()
        }
    }
    
    func deleteEntity(entity: Entity) {
        for object in self.fetchEntity(entity) {
            self.moc.deleteObject(object)
        }
    }
    
    func save() {
        do {
            try self.moc.save()
        }
        catch {
        }
    }
}