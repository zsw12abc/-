//
//  Courses.swift
//  ParseStarterProject-Swift
//
//  Created by ShaoweiZhang on 15/10/23.
//  Copyright © 2015年 Parse. All rights reserved.
//

import Foundation
import Parse

class Course : PFObject, PFSubclassing {
    @NSManaged var name: String;
    @NSManaged var schedule: Array<NSDate>;
    @NSManaged var hours: Int;
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
        return "Course"
    }
    
//    init(name: String, schedule: Array<NSDate>, hours: Int) {
//        super.init()
//        self.name = name;
//        if(self["schedule"] != nil){
//            self.schedule = self["schedule"] as! Array<NSDate>;
//        }else{
//            self.schedule = [];
//        }
//        self.hours = hours;
//    }
    
    override init() {
        super.init()
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
            }
        }
    }
    
    func updateOnline(){
        let query = PFQuery(className:"Course");
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
                    (course: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else if let course = course {
                        course["name"] = self.name;
                        course["hours"]=self.hours;
                        course["schedule"] = self.schedule;
                        course.saveInBackground();
                        print(course);
                    }
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)");
            }
        }
    }
    
    func searchOnline(){
        let query = PFQuery(className:"Course");
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
    
    func getOnline(id: String) -> PFObject{
        let query = PFQuery(className:"Course")
        query.getObjectInBackgroundWithId(id) {
            (course: PFObject?, error: NSError?) -> Void in
            if error == nil && course != nil {
                print(course);
                
            } else {
                print(error)
            }
        }
        return self;
    }

    
}