//
//  Bool+Utilities.swift
//  BGCSproutWorkshop2021
//
//  Created by Allison Schwarz on 7/17/21.
//

import Foundation

public extension Bool {
    
    //Toggle bool value, returns true if value was changed, false otherwise
    @discardableResult
    mutating func toggle(_ toValue: Bool) -> Bool {
        guard self != toValue else {return false}
        self = toValue
        return true
    }
}
