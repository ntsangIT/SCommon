//
//  SAlert.swift
//  Core
//
//  Created by Thanh Sang on 11/14/20.
//  Copyright © 2020 FLYG. All rights reserved.
//

import UIKit

class AlertPage: UIAlertController {
    
    private var alertWindow: UIWindow? = nil
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hide()
    }
    
    fileprivate func show() {
        let blankViewController = UIViewController()
        blankViewController.view.backgroundColor = .clear
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = blankViewController
        window.backgroundColor = .clear
        window.windowLevel = UIWindow.Level.alert + 1
        window.makeKeyAndVisible()
        alertWindow = window
        
        blankViewController.present(self, animated: true)
    }
    
    fileprivate func hide() {
        alertWindow?.isHidden = true
        alertWindow = nil
    }
    
    fileprivate func addAction(_ actions: [UIAlertAction]) {
        actions.forEach { (action) in
            self.addAction(action)
        }
    }
}

/// This class show custom alert with any view or show default alert controller.
open class SAlert: NSObject {
    
    /// This struct wrapper function for show Custom alert view from top UIViewController.
    public struct custom: SAlertProtocol {
        
        private var messageString: String?
        private var titleString: String?
        private var okCompletion: CompletionHandler?
        private var cancelCompletion: CompletionHandler?
        private var view: UIView?
        private var classType: String?
        
        /// prevent init this struct
        private init() { }
    }
    
    /// This struct wrapper function for show UIAlertController from top UIViewControler.
    public struct `default`: SAlertProtocol {
        /// prevent init this struct
        private init() { }
    }
}

/// implement Abstract for default alert
extension SAlert.`default` {
    public static func show(_ message: String,
                          title: String? = nil,
                          okCompletion: Self.CompletionHandler? = nil) {
        
        let alert = AlertPage(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            if let completion = okCompletion {
                completion()
            }
        }
        alert.addAction(okAction)
        DispatchQueue.main.async {
            alert.show()
        }
    }
    
    public static func show(_ message: String, title: String, okCompletion: Self.CompletionHandler?, cancelCompletion: Self.CompletionHandler?) {
        let alert = AlertPage(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            if let completion = okCompletion {
                completion()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            if let completion = cancelCompletion {
                completion()
            }
        }
        alert.addAction([okAction, cancelAction])
        DispatchQueue.main.async {
            alert.show()
        }
    }
    
    public static func showActionSheet(_ message: String?, title: String? = nil, actionTitles: [Self.ActionSheetTitle], completionHandler: Self.CompletionHandlerActionSheet? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        actionTitles.forEach { (title, index) in
            let action = UIAlertAction(title: title, style: .default) { (_) in
                if let completion = completionHandler {
                    completion((title, index))
                }
            }
            alert.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            // todo later
        }
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            // todo get top view and present
        }
    }
}

/// implement Abstract for custom alert
extension SAlert.custom {
    public static func show(_ message: String, title: String?, okCompletion: Self.CompletionHandler?) {
        // todo later
    }
    
    public static func show(_ message: String, title: String, okCompletion: Self.CompletionHandler?, cancelCompletion: Self.CompletionHandler?) {
        // todo later
    }
    
    // MARK: Private and internal method.
    
    public init(withView view: UIView?,
                  message: String?,
                  title: String?,
                  okCompletion: Self.CompletionHandler?,
                  camcelCompletion: Self.CompletionHandler?) {
        
        guard let view = view else {
            return
        }
        
        let viewControler: UIViewController = UIViewController()
        viewControler.view.frame = view.frame
        viewControler.view.addSubview(view)
        
        // todo add title message, completion
        
        DispatchQueue.main.async {
            // todo get top view and present
        }
    }
    
    internal init<T>(withType type: T.Type,
                     message: String?,
                     title: String?,
                     okCompletion: Self.CompletionHandler?,
                     camcelCompletion: Self.CompletionHandler?) {
        // todo later
    }
}
