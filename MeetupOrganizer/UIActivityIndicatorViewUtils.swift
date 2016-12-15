//
//  UIActivityIndicatorViewUtils.swift
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

class UIActivityIndicatorViewUtils
{
    
    var activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    
    static let sharedInstance = UIActivityIndicatorViewUtils()
 
    func showActivityIndicatorInView(view: UIView)
    {
        // HEX# ed1c40 http://uicolor.xyz/ this is amazing! 
        
        let meetupRedColor = UIColor(red:0.93, green:0.11, blue:0.25, alpha:1.0)
        
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0), type: .ballGridPulse, color: meetupRedColor, padding: 0)
        
        activityIndicatorView.center = view.center
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    
    func hideActivityIndicatorInView()
    {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
    }
    
}
