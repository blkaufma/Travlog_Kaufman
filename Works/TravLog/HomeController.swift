//
//  HomeController.swift
//  TravLog
//
//  Created by Paul D'Amora on 10/28/15.
//  Copyright © 2015 TravLog. All rights reserved.
//

import UIKit
import CoreLocation

class HomeController: UIViewController, CLLocationManagerDelegate , PiechartDelegate {
    //Variable Declaration
    var total: CGFloat = 1
    var itemMode = ""
    var busCount: CGFloat = 0.0
    var planeCount: CGFloat = 0.0
    var carCount: CGFloat = 0.0
    var trainCount: CGFloat = 0.0
    var otherCount: CGFloat = 0.0

    override func viewDidLoad() {
        
    getRefresh()
    super.viewDidLoad()
        
        
    }
    
    func makePie(){
        //make piechart
        var views: [String: UIView] = [:]
        
        var Bus = Piechart.Slice()
        Bus.value = busCount / total
        Bus.color = UIColor.orangeColor()
        Bus.text = "Bus"
        
        var Plane = Piechart.Slice()
        Plane.value = planeCount / total
        Plane.color = UIColor.redColor()
        Plane.text = "Plane"
        
        var Car = Piechart.Slice()
        Car.value = carCount / total
        Car.color = UIColor.magentaColor()
        Car.text = "Car"
        
        var Train = Piechart.Slice()
        Train.value = trainCount / total
        Train.color = UIColor.blueColor()
        Train.text = "Train"
        
        var Other = Piechart.Slice()
        Other.value = otherCount / total
        Other.color = UIColor.grayColor()
        Other.text = "Other"
        
        let piechart = Piechart()
        piechart.delegate = self
        piechart.title = "Mode Choice"
        piechart.activeSlice = 2
        piechart.layer.borderWidth = 1
        piechart.slices = [Bus, Plane, Car, Train,  Other]
        
        piechart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(piechart)
        views["piechart"] = piechart
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[piechart]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[piechart(==100)]", options: [], metrics: nil, views: views))
    }
    
    /*
    Get Request
    */
    
    func getRefresh() {
        
        //Username
        let userName = "IanFoertsch"
        
        let urlstr : String = "http://ec2-54-208-153-2.compute-1.amazonaws.com/Travlog/location?userIdentifier="+userName
        print (urlstr)
        guard let url = NSURL(string: urlstr) else {
            print("Error: cannot create URL")
            return
        }
        
        let urlRequest = NSMutableURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue:NSOperationQueue.mainQueue(), completionHandler: {
            (response, data, error) in
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            guard error == nil else {
                print("error calling GET")
                print(error)
                return
            }
            
            let dict : NSDictionary
            do {
                dict =
                    try NSJSONSerialization.JSONObjectWithData(responseData, options: [])
                    as! NSDictionary as! [String : NSArray]
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            if let locations = dict["locations"]
            {
                self.total = CGFloat(locations.count)
                for index in 0...(locations.count-1) {
                    
                    let itemMode = String(locations[index]["mode"])
                    
                    if itemMode == "Optional(Bus)"
                        {
                            self.busCount++
                        }
                    if itemMode == "Optional(Plane)"
                        {
                            self.planeCount++
                        }
                    if itemMode == "Optional(Car)"
                        {
                            self.carCount++
                        }
                    if itemMode == "Optional(Train)"
                        {
                            self.trainCount++
                        }
                    if itemMode == "Optional(Other)"
                        {
                            self.otherCount++
                        }
                    self.makePie()
                }
                
            }
            })

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setSubtitle(slice: Piechart.Slice) -> String {
        return "\(Int(slice.value * 100))% \(slice.text)"
    }
    
    func setInfo(slice: Piechart.Slice) -> String {
        return "\(Int(slice.value * total))/\(Int(total))"
    }
    
    func locationIterator(array:NSArray) {
        for element in array{
            print("\(element)")
        }
    }

    // MARK: Actions
    /* User leaves region
    add local push notification for x hours in the future
    survey waiting = true
    */
    
    
}