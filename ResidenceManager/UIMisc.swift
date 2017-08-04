//
//  UIMisc.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-08-04.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class UIMisc {
    static func setDefaultStyle(toNavigation nav: UINavigationController?, isRoot: Bool = false) {
        if let bar = nav?.navigationBar {
            bar.barTintColor = RMColor.navBg
            bar.titleTextAttributes = [NSForegroundColorAttributeName: RMColor.navText]
            bar.tintColor = RMColor.navText
        }
    }
}
