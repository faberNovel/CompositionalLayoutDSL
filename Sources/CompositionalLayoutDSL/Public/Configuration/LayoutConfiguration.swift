//
//  CompositionalLayoutConfiguration.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 12/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

/// A type that represents a compositional layout configuration and provides
/// modifiers to change the configuration.
///
/// You create custom configuration by declaring types that conform to the
/// ``LayoutConfiguration`` protocol. Implement the required ``layoutConfiguration``
/// computed property to provide your customized settings.
///
///     struct MyConfiguration: LayoutConfiguration {
///         var layoutConfiguration: LayoutConfiguration {
///             Configuration()
///                 .scrollDirection(.horizontal)
///                 .interSectionSpacing(16)
///                 .contentInsetsReference(.readableContent)
///         }
///     }
///
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
