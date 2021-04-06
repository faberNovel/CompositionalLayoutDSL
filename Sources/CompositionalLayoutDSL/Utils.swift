//
//  Utils.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 06/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import Foundation

func with<T>(_ object: T, modifier: (inout T) -> Void) -> T {
    var copy = object
    modifier(&copy)
    return copy
}
