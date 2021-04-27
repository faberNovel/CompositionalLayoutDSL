//
//  CompositionalLayoutConfiguration.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 12/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

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

    #if os(macOS)
    /// Configure the axis that the content in the collection view layout scrolls along.
    ///
    /// The default value of this property is `NSCollectionView.ScrollDirection.vertical`.
    @warn_unqualified_access
    public func scrollDirection(
        _ scrollDirection: NSCollectionView.ScrollDirection
    ) -> LayoutConfiguration {
        valueModifier(scrollDirection, keyPath: \.scrollDirection)
    }
    #else
    /// Configure the axis that the content in the collection view layout scrolls along.
    ///
    /// The default value of this property is `UICollectionView.ScrollDirection.vertical`.
    @warn_unqualified_access
    public func scrollDirection(
        _ scrollDirection: UICollectionView.ScrollDirection
    ) -> LayoutConfiguration {
        valueModifier(scrollDirection, keyPath: \.scrollDirection)
    }
    #endif

    /// Configure the amount of space between the sections in the layout.
    ///
    /// The default value of this property is `0.0`.
    @warn_unqualified_access
    public func interSectionSpacing(_ interSectionSpacing: CGFloat) -> LayoutConfiguration {
        valueModifier(interSectionSpacing, keyPath: \.interSectionSpacing)
    }

    /// Add an array of the supplementary items that are associated with the boundary edges
    /// of the entire layout, such as global headers and footers.
    @warn_unqualified_access
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

    #if !os(macOS)
    /// Configure the boundary to reference when defining content insets.
    ///
    /// The default value of this property is ``UIContentInsetsReference.safeArea``
    @available(iOS 14.0, tvOS 14.0, *)
    @warn_unqualified_access
    public func contentInsetsReference(
        _ contentInsetsReference: UIContentInsetsReference
    ) -> LayoutConfiguration {
        valueModifier(contentInsetsReference, keyPath: \.contentInsetsReference)
    }
    #endif
}
