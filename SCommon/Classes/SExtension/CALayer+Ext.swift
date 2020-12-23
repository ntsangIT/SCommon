//
//  CALayer+Ext.swift
//  SCommon
//

import UIKit

public extension CALayer {

    func toImage(_ isOpaque: Bool = false) -> UIImage? {
        defer { UIGraphicsEndImageContext() }
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
