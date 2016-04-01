//
//  CompareUtils.swift
//  Escuela
//
//  Created by Pedro Alonso on 10/12/15.
//  Copyright © 2015 Pedro. All rights reserved.
//

import Foundation


extension NSDate: Comparable {
    
}

public func <(left: NSDate, right: NSDate) -> Bool {
    return left.compare(right) == NSComparisonResult.OrderedAscending
}