//
//  AlertHelper.swift
//  unv_test
//
//  Created by Alex Oliynyk on 04.01.2025.
//

import Foundation
import UIKit

class AlertHelper: NSObject {
    class func showForTime(title: String?, for time: Double = 0.5) {
        guard let title = title, let vc = UIApplication.topViewController() else {
            return
        }

        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.view.tintColor = .black

        vc.present(alertController, animated: true, completion: {
            Timer.scheduledTimer(withTimeInterval: time, repeats: false, block: { _ in
                alertController.dismiss(animated: true, completion: nil)
            })
        })
    }
}
