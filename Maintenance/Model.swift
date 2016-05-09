//
//  Model.swift
//  Maintenance
//
//  Created by Marcus Shannon on 5/8/16.
//  Copyright © 2016 Metro Self Storage. All rights reserved.
//

import UIKit
import CoreData

protocol DataModel {
    func serviceRequestCount() -> Int
}

class Model: DataModel {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var moc: NSManagedObjectContext!
    
    init() {
        self.moc = appDelegate.dataController.managedObjectContext
    }
    
    func serviceRequestCount() -> Int {
        return self.moc.countForFetchRequest(NSFetchRequest(entityName: "ServiceRequest"), error: nil)
    }
    
    func addServiceRequest() {
        NSEntityDescription.insertNewObjectForEntityForName("ServiceRequest", inManagedObjectContext: moc)
        self.save()
    }
    
    func deleteServiceRequest() {
        let serviceRequestFetchRequest = NSFetchRequest(entityName: "ServiceRequest")
        do {
            let fetchedServiceRequests = try self.moc.executeFetchRequest(serviceRequestFetchRequest)
            for serviceRequest in fetchedServiceRequests {
                self.moc.deleteObject(serviceRequest as! NSManagedObject)
            }
        } catch {
            
        }
        self.save()
    }
    
    func save() {
        do {
            try self.moc.save()
        }
        catch {
            
        }
    }
    
    func getServiceRequest() -> ServiceRequest? {
        let serviceRequestFetchRequest = NSFetchRequest(entityName: "ServiceRequest")
        do {
            let fetchedServiceRequests = try self.moc.executeFetchRequest(serviceRequestFetchRequest) as! [ServiceRequest]
            return fetchedServiceRequests[0]
        } catch {
            
        }
        return nil
    }
}