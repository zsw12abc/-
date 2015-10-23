/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
    var courseIDList : Array<String> = [];

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let shaowei = Lecturer(name: "Shaowei", phone: "0433073158", email: "Shaowei.zhang@linghang.education");
//        shaowei.createOnline();
//        shaowei.updateOnline();
        
//        let ara = Course(name: "ARA", schedule: [], hours: 12);
//        ara.createOnline();
//        let apa = Course(name: "APA", schedule: [], hours: 12);
//        apa.createOnline();
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //判断是哪个 segue way 根据 id 来判断
        if segue.identifier == "courseSegue" {
            let vc = segue.destinationViewController as! CoursesViewController;
           
            
        }
    }
    
    @IBAction func CourseButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("courseSegue", sender: sender);
        
    }

}
