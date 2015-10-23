//
//  Lecturers.swift
//  ParseStarterProject-Swift
//
//  Created by ShaoweiZhang on 15/10/22.
//  Copyright © 2015年 Parse. All rights reserved.
//

import Foundation
import Parse

class Lecturer : PFObject, PFSubclassing {
    @NSManaged var name: String;
    @NSManaged var phone: String;
    @NSManaged var email: String;
    @NSManaged var courses: Array<PFObject>;
    @NSManaged var schedule: Array<NSDate>;
    @NSManaged var id: String;
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    
    static func parseClassName() -> String {
        return "Lecturer"
    }
    
    init(name: String, phone: String, email: String) {
        super.init()
        self.name = name;
        self.phone = phone;
        self.email = email;
        if (self["courses"] != nil){
            self.courses = self["courses"] as! Array<PFObject>;
        }else{
            self.courses = [];
        }
        if (self["schedule"] != nil){
            self.schedule = self["schedule"] as! Array<NSDate>;
        }else{
            self.schedule = [];
        }
    }
    
    override init() {
        super.init()
    }
    
    
    override class func query() -> PFQuery? {
        let query = PFQuery(className: Lecturer.parseClassName())
        query.includeKey("user")
        query.orderByDescending("createdAt")
        return query
    }
    
    func createOnline(){
        self.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print(self);
                print(self.objectId);
            } else {
                // There was a problem, check error.description
                print(error);
            }        }
    }
    
    func updateOnline(){
        let query = PFQuery(className:"Lecturer");
        query.whereKey("name", equalTo:self.name);
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects  {
                    for object in objects {
                        self.id = object.objectId!;
                    }
                }
                query.getObjectInBackgroundWithId(self.id) {
                    (lecturer: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else if let lecturer = lecturer {
                        lecturer["name"] = self.name;
                        lecturer["phone"] = self.phone;
                        lecturer["email"] = self.email;
                        lecturer["courses"] = self.courses;
                        lecturer["schedule"] = self.schedule;
                        lecturer.saveInBackground();
                        print(lecturer);
                    }
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)");
            }
        }
    }
    
    func searchOnline(){
        let query = PFQuery(className:"Lecturer");
        query.whereKey("name", equalTo:self.name);
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects  {
                    for object in objects {
                        self.id = object.objectId!;
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)");
            }
        }
    }
    
}