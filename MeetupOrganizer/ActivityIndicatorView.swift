//
//  ActivityIndicatorView.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 12/15/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class ActivityIndicatorView {
    
    static let sharedInstance = ActivityIndicatorView()

    private var activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    
    
    func showActivityIndicator(in view: UIView) {
        
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0),
                                                        type: .ballGridPulse,
                                                        color: UIColor.meetupRedColor,
                                                        padding: 0)
        
        activityIndicatorView.center = view.center
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    
    func hideActivityIndicator() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
    }
    
}
