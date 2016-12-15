//
//  UIActivityIndicatorView+Utilities.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 12/15/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension UIView
{
    
    func addActivityIndicatorToView(view: UIView)
    {
        let cols = 4
        let cellWidth = Int(view.frame.width / CGFloat(cols))
        let xCenter = Int(view.frame.width / 2)
        let yCenter = Int(view.frame.height / 2)
        let frame = CGRect(x: xCenter, y: yCenter, width: cellWidth, height: cellWidth)
        //        let meetupRedColor = // add later TODO
        
        let activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .ballGridPulse, color: UIColor.red, padding: 0)
        
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.startAnimating()
    }
    
    
    
}
