//
//  EdgeSpacable.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 14/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public protocol EdgeSpacable {
    func edgeSpacing(value: NSCollectionLayoutSpacing?) -> Self
    func edgeSpacing(
        horizontal: NSCollectionLayoutSpacing?,
        vertical: NSCollectionLayoutSpacing?
    ) -> Self

    func edgeSpacing(
        top: NSCollectionLayoutSpacing?,
        leading: NSCollectionLayoutSpacing?,
        bottom: NSCollectionLayoutSpacing?,
        trailing: NSCollectionLayoutSpacing?
    ) -> Self
}

public extension EdgeSpacable {
    func edgeSpacing(value: NSCollectionLayoutSpacing?) -> Self {
        return edgeSpacing(top: value, leading: value, bottom: value, trailing: value)
    }

    func edgeSpacing(
        horizontal: NSCollectionLayoutSpacing? = nil,
        vertical: NSCollectionLayoutSpacing? = nil
    ) -> Self {
        return edgeSpacing(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}

internal protocol HasEdgeSpacingProperties {
    var edgeSpacing: NSCollectionLayoutEdgeSpacing { get set }
}

extension HasEdgeSpacingProperties {

    public func edgeSpacing(
        top: NSCollectionLayoutSpacing?,
        leading: NSCollectionLayoutSpacing?,
        bottom: NSCollectionLayoutSpacing?,
        trailing: NSCollectionLayoutSpacing?
    ) -> Self {
        with(self) {
            $0.edgeSpacing = NSCollectionLayoutEdgeSpacing(
                leading: leading,
                top: top,
                trailing: trailing,
                bottom: bottom
            )
        }
    }
}
