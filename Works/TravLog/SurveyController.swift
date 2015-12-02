//
//  SurveryController.swift
//  TravLog
//
//  Created by Ben Kaufman on 10/24/15.
//  Copyright © 2015 TravLog. All rights reserved.
//

import UIKit
import CoreLocation

class SurveyController: UIViewController {
    
    override func viewDidLoad(){
        super.viewDidLoad()
       
        // Grab the user's current location, store in variable
        

    }
    
    // MARK: Properties
    // outlets for survey form objects
    @IBOutlet weak var labelMode: UILabel!
    
  
    // MARK: Actions
    /* Two variables we need to worry about (mode, reason)
        Each button has an action and will change those variables
    */
    @IBAction func buttonPlane(sender: UIButton) {
        _ = sender.currentTitle!
        labelMode.text = sender.currentTitle!
    }
    @IBAction func buttonBus(sender: UIButton) {
        _ = sender.currentTitle!
        labelMode.text = sender.currentTitle!
    }
    @IBAction func buttonTrain(sender: UIButton) {
        _ = sender.currentTitle!
        labelMode.text = sender.currentTitle!
    }
    @IBAction func buttonOther(sender: UIButton) {
        _ = sender.currentTitle!
        labelMode.text = sender.currentTitle!
    }
    @IBAction func buttonCar(sender: UIButton) {
        _ = sender.currentTitle!
        labelMode.text = sender.currentTitle!
    }
    
    
    /* "I Didn't Travel" button press
        survey waiting = false
        proceed to home screen
    */
    @IBAction func buttonDidntTravel(sender: UIButton) {
    }
    
    /* "Wrong Location" button press
        show modal with new location form
    */
    
    /* "Submit" button press
    save to database, go to profile screen
    */
    
    @IBAction func buttonSubmit(sender: UIButton) {
        
        //Grab user's date
        let date = NSDate().timeIntervalSince1970
        let time: Double = date*1000
        
        let locationObject: [String:AnyObject] = [

                    "locationLong":1.0,
                    "locationLat":1.0,
                    "mode":labelMode.text!,
                    "purpose":"business",
                    "speed":1.0,
                    "course":1.0,
                    "altitude":1.0,
                    "userIdentifier":"IanFoertsch",
                    "recordDate":time
        ]
        
        let urlString: String = "http://ec2-54-208-153-2.compute-1.amazonaws.com/Travlog/location"
        sendPostRequest(locationObject, urlstr: urlString)
        
    }
    
    /*
    Restful Communication
    */
    
    
    func sendPostRequest(sendMe:[String:AnyObject], urlstr:String)
    {
        guard let url = NSURL(string: urlstr) else {
            print("Error: cannot create URL")
        return
        }
        
        let urlRequest = NSMutableURLRequest(URL: url)  // must be mutable to set the http method
        urlRequest.HTTPMethod = "POST"
        
        
        urlRequest.setValue("application/json", forHTTPHeaderField:"Content-Type")
        
        do  {
                let jsonData = try NSJSONSerialization.dataWithJSONObject(sendMe, options: [])
                urlRequest.HTTPBody = jsonData
                NSURLConnection.sendAsynchronousRequest(urlRequest, queue:NSOperationQueue.mainQueue(), completionHandler:
                {
                    (response, data, error) in
                    guard let _ = data else
                    {
                        print("Error: did not receive data")
                        return
                    }
                    guard error == nil else
                    {
                        print("error calling POST")
                        return
                    }
                })
            }
                
    catch   {
                print("json error: \(error)")
            }
        
    }
}
