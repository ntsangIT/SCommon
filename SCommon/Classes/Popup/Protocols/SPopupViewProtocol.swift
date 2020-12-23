//
//  SPopupViewProtocol.swift
//  Core
//
//  Created by Thanh Sang on 12/3/20.
//  Copyright © 2020 FLYG. All rights reserved.
//

import UIKit

/// PopView type for Page to implement as a pop view
public protocol IPopupView: class {
    
    /*
     Setup popup layout
     
     Popview is a UIViewController base, therefore it already has a filled view in. This method allows
     implementation to layout it customly. For example:
     
     ```
     view.cornerRadius = 7
     view.autoCenterInSuperview()
     ```
     */
    func popupLayout()
    
    /*
     Show animation
     
     The presenter page has overlayView, use this if we want to animation the overlayView too, e.g alpha
     */
    func show(overlayView: UIView)
    
    /*
     Hide animation
     
     Must call completion when the animation is finished
     */
    func hide(overlayView: UIView, completion: @escaping (() -> ()))
}
