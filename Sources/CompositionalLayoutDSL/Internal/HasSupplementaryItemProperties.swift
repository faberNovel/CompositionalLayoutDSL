//
//  HasSupplementaryItemProperties.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 15/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

internal protocol HasSupplementaryItemProperties: HasItemProperties {
    var zIndex: Int { get set }
}

extension NSCollectionLayoutSupplementaryItem {
    func apply(supplementaryPropertiesFrom propertiesHolder: HasSupplementaryItemProperties) {
        apply(itemPropertiesFrom: propertiesHolder)
        self.zIndex = propertiesHolder.zIndex
    }
}
