//
//  CoursesViewController.swift
//  ParseStarterProject-Swift
//
//  Created by ShaoweiZhang on 15/10/23.
//  Copyright © 2015年 Parse. All rights reserved.
//

import UIKit
import Parse

class CoursesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate {
    var courseIDList : Array<String> = [];
    var filteredCourse: Array<String> = [];

    @IBOutlet weak var courseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let query = PFQuery(className:"Course")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object.objectId)
                        self.courseIDList.append(object.objectId!);
                    }
                }
                print("courseIDList VC: \(self.courseIDList)");
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        navigationItem.leftBarButtonItem = editButtonItem();
        var contentOffset = courseTableView.contentOffset
        contentOffset.y += searchDisplayController!.searchBar.frame.size.height
        courseTableView.contentOffset = contentOffset

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @available(iOS 2.0, *)
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if courseTableView == searchDisplayController?.searchResultsTableView{
            return filteredCourse.count;
        }else {
            return courseIDList.count;
        }
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.courseTableView.dequeueReusableCellWithIdentifier("courseCell") as UITableViewCell!;
        
        var courseID: String;
        let courseName = cell.viewWithTag(101) as! UILabel;
        let courseLecturer = cell.viewWithTag(102) as! UILabel;
        let courseHour = cell.viewWithTag(103) as! UILabel;
        
        if tableView == searchDisplayController?.searchResultsTableView{
            courseID = filteredCourse[indexPath.row];
        } else {
            courseID = courseIDList[indexPath.row];
        }
        let query = PFQuery(className:"Course")
        query.getObjectInBackgroundWithId(courseID) {
            (course: PFObject?, error: NSError?) -> Void in
            if error == nil && course != nil {
                print(course);
                courseName.text = course!["name"] as! String;
                courseHour.text = course!["hours"] as! String;
                courseLecturer.text = course!["lecturer"]["name"] as! String;
                
            } else {
                print(error)
            }
        }
        
        
        
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
    if editingStyle == UITableViewCellEditingStyle.Delete{
    courseIDList.removeAtIndex(indexPath.row)
    //删除数据后要重新刷新 table
    //self.tableView.reloadData()
    //加入删除的动画效果
    self.courseTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    }


}
