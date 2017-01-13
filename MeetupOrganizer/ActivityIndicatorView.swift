//
//  ActivityIndicatorView.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 12/15/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//


//                    let cols = 4
//                    let cellWidth = Int(self.view.frame.width / CGFloat(cols))
//                    let xCenter = Int(self.view.frame.width / 2)
//                    let x = Int(xCenter - cellWidth / 2)
//                    let yCenter = Int(self.view.frame.height / 2)
//                    let y = Int(yCenter - cellWidth / 2)


import UIKit
import NVActivityIndicatorView

class ActivityIndicatorView
{
    
    static let sharedInstance = ActivityIndicatorView()

    var activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)) // should be private let
    
    
    func showActivityIndicatorInView(view: UIView)
    {
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0), type: .ballGridPulse, color: MeetupRedColor, padding: 0)
        
        activityIndicatorView.center = view.center
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    
    func hideActivityIndicatorInView() // rename to hideActivityIndicator()
    {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
    }
    
}
