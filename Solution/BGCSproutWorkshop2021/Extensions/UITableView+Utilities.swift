//
//  UITableView+Utilities.swift
//  BGCSproutWorkshop2021
//
//  Created by Allison Schwarz on 7/17/21.
//

import UIKit

public extension UITableView {
    func safeReload() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
