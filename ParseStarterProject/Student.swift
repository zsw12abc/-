//
//  Students.swift
//  ParseStarterProject-Swift
//
//  Created by ShaoweiZhang on 15/10/23.
//  Copyright © 2015年 Parse. All rights reserved.
//

import Foundation
import Parse

class Student : PFObject, PFSubclassing {
    @NSManaged var name: String;
    @NSManaged var phone: String;
    @NSManaged var email: String;
    @NSManaged var courses: Array<PFObject>;
    
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    
    static func parseClassName() -> String {
        return "Student"
    }
    
    init(name: String, phone: String, email: String) {
        super.init()
        self.name = name;
        self.phone = phone;
        self.email = email;
        self.courses = self["courses"] as! Array<PFObject>;
    }
    
    override init() {
        super.init()
    }
    
    
    override class func query() -> PFQuery? {
        let query = PFQuery(className: Student.parseClassName())
        query.includeKey("user")
        query.orderByDescending("createdAt")
        return query
    }
    
}