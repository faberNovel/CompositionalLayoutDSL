//
//  HasDecorationItemProperties.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 15/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

internal protocol HasDecorationItemProperties: HasItemProperties {
    var zIndex: Int { get set }
}

extension NSCollectionLayoutDecorationItem {
    func apply(decorationPropertiesFrom propertiesHolder: HasDecorationItemProperties) {
        apply(itemPropertiesFrom: propertiesHolder)
        self.zIndex = propertiesHolder.zIndex
    }
}
