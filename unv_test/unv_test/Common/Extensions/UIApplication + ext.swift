//
//  UIApplication + ext.swift
//  unv_test
//
//  Created by Alex Oliynyk on 04.01.2025.
//

import UIKit

extension UIApplication {
    class func topViewController(_ base: UIViewController? = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }

        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }

        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }

        return base
    }
}
