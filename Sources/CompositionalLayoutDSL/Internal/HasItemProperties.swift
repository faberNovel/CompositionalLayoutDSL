//
//  HasItemProperties.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 15/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

internal protocol HasItemProperties: HasResizableProperties {}

internal extension NSCollectionLayoutItem {
    func apply(itemPropertiesFrom propertiesHolder: HasItemProperties) {
    }
}
