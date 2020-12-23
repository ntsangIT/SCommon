//
//  SAlertProtocol.swift
//  Core
//
//  Created by Thanh Sang on 12/2/20.
//  Copyright © 2020 FLYG. All rights reserved.
//

import UIKit

/// Abstract for SAlert.
public protocol SAlertProtocol {

    typealias CompletionHandler = () -> ()
    typealias CompletionHandlerActionSheet = (ActionSheetTitle) -> ()
    typealias ActionSheetTitle = (title: String, index: Int)
    
    /// Funtion init using for Custom alert view.
    /// - Parameters:
    ///   - view: custom alert view (UIView)
    ///   - message: message to display on custom alert view. (String)
    ///   - title: title to display on custom alert view. (String)
    ///   - okCompletion: handle completion when tap OK button. (block completion)
    ///   - camcelCompletion: handle completion when tap Cancel button. (block completion)
    init(withView view: UIView?, message: String?, title: String?, okCompletion: CompletionHandler?, camcelCompletion: CompletionHandler?)
    
    /// Funtion init using for Custom alert view.
    /// - Parameters:
    ///   - type: type of class.
    ///   - message: message to display on custom alert view. (String)
    ///   - title: title to display on custom alert view. (String)
    ///   - okCompletion: handle completion when tap OK button. (block completion)
    ///   - cancelCompletion: handle completion when tap Cancel button. (block completion)
    init<T>(withType type: T.Type, message: String?, title: String?, okCompletion: CompletionHandler?, cancelCompletion: CompletionHandler?)
    
    /// Function show alert message with OK button
    /// - Parameters:
    ///   - message: message to display on alert. (String)
    ///   - title: title to display on alert. (String)
    ///   - okCompletion: handle completion when tap OK button. (block completion)
    /// Usage:
    /// SAlert.default.showAlert("message")
    /// SAlert.default.showAlert("message", title: "title")
    /// SAlert.default.showAlert("message", title: "title") {
            // Handle completion when tap OK button.
    /// }
    static func show(_ message: String, title: String?, okCompletion: CompletionHandler?)
    
    /// Function show alert message with OK button
    /// - Parameters:
    ///   - message: message to display on alert.
    ///   - title: title to display on alert.
    ///   - okCompletion: handle completion when tap OK button. (block completion)
    ///   - cancelCompletion: handle completion when tap Cancel button. (block completion)
    /// Usage:
    /// SAlert.default.showAlert("message", title: "title", okCompletion: {
    ///    // Handle completion when tap OK button.
    /// }, cancelCompletion: {
    ///    // Handle completion when tap Cancel button.
    /// })
    static func show(_ message: String, title: String, okCompletion: CompletionHandler?, cancelCompletion: CompletionHandler?)
    
    /// Function show alert with style action sheet.
    /// - Parameters:
    ///   - message: message to display on alert action sheet. (String)
    ///   - title: title to display on alert action sheet. (String)
    ///   - actionTitles: titles action to display on action sheet.
    ///   - completionHandler: handle completion when tap any action. (block completion)
    /// Usage:
    /// let actionTitles = [("OK", 1)]
    /// SAlert.default.showActionSheet("message", title: "title", actionTitles: actionTitles) { (tittle, index) in
    ///    // Handle completion when select action with title and index
    /// }
    static func showActionSheet(_ message: String?, title: String?, actionTitles: [Self.ActionSheetTitle], completionHandler: CompletionHandlerActionSheet?)
}

/// optional funtion.
extension SAlertProtocol {
    public init(withView view: UIView?, message: String?, title: String?, okCompletion: CompletionHandler?, camcelCompletion: CompletionHandler?) {
        self.init(withView: view, message: message, title: title, okCompletion: okCompletion, camcelCompletion: camcelCompletion)
    }

    public init<T>(withType type: T.Type, message: String?, title: String?, okCompletion: CompletionHandler?, cancelCompletion: CompletionHandler?) {
        self.init(withType: type, message: message, title: title, okCompletion: okCompletion, cancelCompletion: cancelCompletion)
    }
    public   
    static func showActionSheet(_ message: String?, title: String?, actionTitles: [Self.ActionSheetTitle], completionHandler: CompletionHandlerActionSheet?) { }
}
