//
//  HasGroupProperties.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 15/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

internal protocol HasGroupProperties: HasItemProperties {
    var supplementaryItems: [LayoutSupplementaryItem] { get set }
    var interItemSpacing: NSCollectionLayoutSpacing? { get set }
}

internal extension NSCollectionLayoutGroup {
    func apply(groupPropertiesFrom propertiesHolder: HasGroupProperties) {
        apply(itemPropertiesFrom: propertiesHolder)
        self.supplementaryItems = propertiesHolder.supplementaryItems.map { $0.makeSupplementaryItem() }
        self.interItemSpacing = propertiesHolder.interItemSpacing
    }
}
