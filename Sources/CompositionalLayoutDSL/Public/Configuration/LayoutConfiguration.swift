//
//  CompositionalLayoutConfiguration.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 12/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public protocol LayoutConfiguration {
    var layoutConfiguration: LayoutConfiguration { get }
}

extension LayoutConfiguration {

    // MARK: - Mutable properties

    public func scrollDirection(
        _ scrollDirection: UICollectionView.ScrollDirection
    ) -> LayoutConfiguration {
        valueModifier(scrollDirection, keyPath: \.scrollDirection)
    }

    public func interSectionSpacing(_ interSectionSpacing: CGFloat) -> LayoutConfiguration {
        valueModifier(interSectionSpacing, keyPath: \.interSectionSpacing)
    }

    public func boundarySupplementaryItems(
        @LayoutBoundarySupplementaryItemBuilder
        _ boundarySupplementaryItems: () -> [LayoutBoundarySupplementaryItem]
    ) -> LayoutConfiguration {
        let boundarySupplementaryItems = boundarySupplementaryItems()
            .map(BoundarySupplementaryItemBuilder.make(from:))
        return valueModifier {
            $0.boundarySupplementaryItems.append(contentsOf: boundarySupplementaryItems)
        }
    }

    @available(iOS 14.0, tvOS 14.0, *)
    public func contentInsetsReference(
        _ contentInsetsReference: UIContentInsetsReference
    ) -> LayoutConfiguration {
        valueModifier(contentInsetsReference, keyPath: \.contentInsetsReference)
    }
}
