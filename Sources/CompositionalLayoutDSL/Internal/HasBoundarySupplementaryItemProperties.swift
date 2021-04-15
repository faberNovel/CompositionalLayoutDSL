//
//  HasBoundarySupplementaryItemProperties.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 15/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

internal protocol HasBoundarySupplementaryItemProperties: HasSupplementaryItemProperties {
    var extendsBoundary: Bool { get set }
    var pinToVisibleBounds: Bool { get set }
}

extension NSCollectionLayoutBoundarySupplementaryItem {
    func apply(boundarysupplementaryPropertiesFrom propertiesHolder: HasBoundarySupplementaryItemProperties) {
        self.apply(supplementaryPropertiesFrom: propertiesHolder)
        self.extendsBoundary = propertiesHolder.extendsBoundary
        self.pinToVisibleBounds = propertiesHolder.pinToVisibleBounds
    }
}
