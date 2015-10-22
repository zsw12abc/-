//
//  Lecturer.swift
//  ParseStarterProject-Swift
//
//  Created by ShaoweiZhang on 15/10/22.
//  Copyright © 2015年 Parse. All rights reserved.
//

import Foundation
import Parse
// Import this header into your Swift bridge header file to
// let Armor know that PFObject privately provides most of
// the methods for PFSubclassing.
// Armor.swift

class Lecturers : PFObject, PFSubclassing {
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Lecturers"
    }
}