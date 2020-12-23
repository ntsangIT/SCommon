//
//  UINavigationController+Ext.swift
//  SCommon
//

import Foundation


#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UINavigationController {
    
    /// Pop ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - animated: Set this value to true to animate the transition (default is true).
    ///   - completion: optional completion handler (default is nil).
    func popViewController(animated: Bool = true,
                           completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    /// Pop ViewController with completion destroys block handler.
    /// - Parameters:
    ///   - animated: Set this value to true to animate the transition (default is true).
    ///   - completions: optional completion handler (default is nil).
    func popViewController(animated: Bool = true,
                           completions: ((UIViewController?) -> Void)? = nil) {
        if animated {
            CATransaction.begin()
            let page = popViewController(animated: animated)
            CATransaction.setCompletionBlock { completions?(page) }
            CATransaction.commit()
        } else {
            let page = popViewController(animated: animated)
            completions?(page)
        }
    }
    
    /// Pop to any view controller (using view index on stack) with completion destroys block handler.
    /// - Parameters:
    ///   - index: index view controller on stack.
    ///   - animated: set this value to true to animate the transition (default is true).
    ///   - completions: optional completion handler (default is nil).
    func popToViewController(at index: Int, animated: Bool, completions: (([UIViewController]?) -> Void)?) {
        let len = viewControllers.count
        if index >= 0 && index < len - 1 {
            if animated {
                CATransaction.begin()
                let pages = popToViewController(viewControllers[index], animated: animated)
                CATransaction.setCompletionBlock { completions?(pages) }
                CATransaction.commit()
            } else {
                let pages = popToViewController(viewControllers[index], animated: animated)
                completions?(pages)
            }
        }
    }
    
    /// Pop to any view controller with completion destroys block handler.
    /// - Parameters:
    ///   - viewController: view destination for pop.
    ///   - animated: set this value to true to animate the transition (default is true).
    ///   - completions: optional completion handler (default is nil).
    func popToViewController(_ viewController: UIViewController, animated: Bool, completions: (([UIViewController]?) -> Void)?) {
        if animated {
            CATransaction.begin()
            let pages = popToViewController(viewController, animated: animated)
            CATransaction.setCompletionBlock { completions?(pages) }
            CATransaction.commit()
        } else {
            let pages = popToViewController(viewController, animated: animated)
            completions?(pages)
        }
    }
    
    /// Pop to root viewcontroler with completion destroys block handler.
    /// - Parameters:
    ///   - animated: set this value to true to animate the transition (default is true).
    ///   - completions: optional completion handler (default is nil).
    func popToRootViewController(animated: Bool, completions: (([UIViewController]?) -> Void)?) {
        if animated {
            CATransaction.begin()
            let pages = popToRootViewController(animated: animated)
            CATransaction.setCompletionBlock { completions?(pages) }
            CATransaction.commit()
        } else {
            let pages = popToRootViewController(animated: animated)
            completions?(pages)
        }
    }
    
    /// Pop ViewController with hidden navigation bar and has completion destroys block handler
    /// - Parameters:
    ///   - hidden: set this value to true to animate the hide navigation bar (default is false).
    ///   - animated: set this value to true to animate the transition (default is true).
    ///   - completions: optional completion handler (default is nil).
    func popWithNavigation(hidden: Bool = false,
                           animated: Bool = true,
                           completions: ((UIViewController?) -> Void)? = nil) {
        if animated {
            CATransaction.begin()
            setNavigationBarHidden(hidden, animated: animated)
            let page = popViewController(animated: animated)
            CATransaction.setCompletionBlock { completions?(page) }
            CATransaction.commit()
        } else {
            setNavigationBarHidden(hidden, animated: animated)
            let page = popViewController(animated: animated)
            completions?(page)
        }
    }
    
    /// Push ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - viewController: viewController to push.
    ///   - completion: optional completion handler (default is nil).
    func pushViewController(_ viewController: UIViewController,
                            animated: Bool = true,
                            completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        if animated {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            pushViewController(viewController, animated: animated)
            CATransaction.commit()
        } else {
            pushViewController(viewController, animated: animated)
            completion?()
        }
    }
    
}

#endif
