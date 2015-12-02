//
//  ChartViewController.swift
//  TravLog
//
//  Created by Ben Kaufman on 11/15/15.
//  Copyright © 2015 TravLog. All rights reserved.
//


import UIKit

class ChartViewScene: UIViewController, PiechartDelegate {
    
    var total: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var views: [String: UIView] = [:]
        
        var Car = Piechart.Slice()
        Car.value = 5 / total
        Car.color = UIColor.magentaColor()
        Car.text = "Car"
        
        var Train = Piechart.Slice()
        Train.value = 6 / total
        Train.color = UIColor.blueColor()
        Train.text = "Train"
        
        var Bus = Piechart.Slice()
        Bus.value = 4 / total
        Bus.color = UIColor.orangeColor()
        Bus.text = "Bus"
        
        var Plane = Piechart.Slice()
        Plane.value = 5 / total
        Plane.color = UIColor.magentaColor()
        Plane.text = "Plane"
        
        var Other = Piechart.Slice()
        Other.value = 5 / total
        Other.color = UIColor.magentaColor()
        Other.text = "Other"
        
        let piechart = Piechart()
        piechart.delegate = self
        piechart.title = "Mode Choice"
        piechart.activeSlice = 2
        piechart.layer.borderWidth = 1
        piechart.slices = [Car, Train, Bus, Plane, Other]
        
        piechart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(piechart)
        views["piechart"] = piechart
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[piechart]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[piechart(==200)]", options: [], metrics: nil, views: views))
        
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
    
}



