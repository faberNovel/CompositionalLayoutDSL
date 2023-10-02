//
//  LayoutSection.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// A type that represents a section in a compositional layout and provides
/// modifiers to configure sections.
///
/// You create custom sections by declaring types that conform to the ``LayoutSection``
/// protocol. Implement the required ``layoutSection`` computed property to
/// provide the content and configuration for your custom section.
///
/// ```swift
/// struct MySection: LayoutSection {
///     var layoutSection: LayoutSection {
///         Section {
///             HGroup(count: 2) { Item() }
///         }
///         .boundarySupplementaryItems {
///             BoundarySupplementaryItem(elementKind: "kind")
///         }
///         .contentInsets(horizontal: 20, vertical: 8)
///     }
/// }
/// ```
///
public protocol LayoutSection {
    var layoutSection: LayoutSection { get }
}

extension LayoutSection {

    /// Configure the amount of space between the groups in the section.
    @warn_unqualified_access
    public func interGroupSpacing(_ spacing: CGFloat) -> LayoutSection {
        valueModifier(spacing, keyPath: \.interGroupSpacing)
    }

    #if !os(macOS)
    /// Configure the boundary to reference when defining content insets.
    ///
    /// This represents the reference point to use when defining contentInsets.
    ///
    /// The default value of this property is `UIContentInsetsReference.automatic`,
    /// which means the section follows the layout configuration’s `contentInsetsReference`.
    @available(iOS 14.0, tvOS 14.0, *)
    @warn_unqualified_access
    public func contentInsetsReference(_ reference: UIContentInsetsReference) -> LayoutSection {
        valueModifier(reference, keyPath: \.contentInsetsReference)
    }
    #endif

    #if os(macOS)
    /// Configure the section's scrolling behavior in relation to the main layout axis.
    ///
    /// The default value of this property is `UICollectionLayoutSectionOrthogonalScrollingBehavior.none`,
    /// which means the section lays out its content along the main axis of its layout, defined by
    /// the layout configuration's `scrollDirection` property. Set a different value for this
    /// property to get the section to lay out its content orthogonally to the main layout axis.
    @warn_unqualified_access
    public func orthogonalScrollingBehavior(
        _ orthogonalScrollingBehavior: NSCollectionLayoutSectionOrthogonalScrollingBehavior
    ) -> LayoutSection {
        valueModifier(orthogonalScrollingBehavior, keyPath: \.orthogonalScrollingBehavior)
    }
    #else
    /// Configure the section's scrolling behavior in relation to the main layout axis.
    ///
    /// The default value of this property is `UICollectionLayoutSectionOrthogonalScrollingBehavior.none`,
    /// which means the section lays out its content along the main axis of its layout, defined by
    /// the layout configuration's `scrollDirection` property. Set a different value for this
    /// property to get the section to lay out its content orthogonally to the main layout axis.
    @warn_unqualified_access
    public func orthogonalScrollingBehavior(
        _ orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
    ) -> LayoutSection {
        valueModifier(orthogonalScrollingBehavior, keyPath: \.orthogonalScrollingBehavior)
    }
    #endif

    #if !os(macOS)
    /// Configure the bounce behavior of the orthogonal section scroll
    @available(iOS 17.0, tvOS 17.0, *)
    @warn_unqualified_access
    public func orthogonalScrollingBounce(
        _ bounce: UICollectionLayoutSectionOrthogonalScrollingProperties.Bounce
    ) -> LayoutSection {
        valueModifier(bounce, keyPath: \.orthogonalScrollingProperties.bounce)
    }

    /// Configure the bounce behavior of the orthogonal section deceleration rate
    @available(iOS 17.0, tvOS 17.0, *)
    @warn_unqualified_access
    public func orthogonalScrollingDecelerationRate(
        _ decelerationRate: UICollectionLayoutSectionOrthogonalScrollingProperties.DecelerationRate
    ) -> LayoutSection {
        valueModifier(decelerationRate, keyPath: \.orthogonalScrollingProperties.decelerationRate)
    }
    #endif

    /// Add an array of the supplementary items that are associated with the boundary edges of
    /// the section, such as headers and footers.
    @warn_unqualified_access
    public func boundarySupplementaryItems(
        @LayoutBoundarySupplementaryItemBuilder
        _ boundarySupplementaryItems: () -> [LayoutBoundarySupplementaryItem]
    ) -> LayoutSection {
        let boundarySupplementaryItems = boundarySupplementaryItems()
            .map(BoundarySupplementaryItemBuilder.make(from:))
        return valueModifier {
            $0.boundarySupplementaryItems.append(contentsOf: boundarySupplementaryItems)
        }
    }

    /// Configure if the section's supplementary items follow the specified content insets for the section.
    ///
    /// The default value of this property is true.
    @warn_unqualified_access
    @available(iOS, introduced: 13.0, deprecated: 16.0, message: "Use supplementaryContentInsetsReference instead")
    @available(tvOS, introduced: 13.0, deprecated: 16.0, message: "Use supplementaryContentInsetsReference instead")
    public func supplementariesFollowContentInsets(
        _ supplementariesFollowContentInsets: Bool
    ) -> LayoutSection {
        valueModifier(supplementariesFollowContentInsets, keyPath: \.supplementariesFollowContentInsets)
    }

    #if !os(macOS)
    /// Configure the section reference boundary for content insets on boundary supplementary items.
    ///
    /// The default value of this property is `.automatic`.
    @available(iOS 16.0, tvOS 16.0, *)
    @warn_unqualified_access
    public func supplementaryContentInsetsReference(
        _ supplementaryContentInsetsReference: UIContentInsetsReference
    ) -> LayoutSection {
        valueModifier(supplementaryContentInsetsReference, keyPath: \.supplementaryContentInsetsReference)
    }
    #endif

    /// Install a closure called before each layout cycle to allow modification of the items in
    /// the section immediately before they are displayed.
    @warn_unqualified_access
    public func visibleItemsInvalidationHandler(
        _ visibleItemsInvalidationHandler: NSCollectionLayoutSectionVisibleItemsInvalidationHandler?
    ) -> LayoutSection {
        valueModifier(visibleItemsInvalidationHandler, keyPath: \.visibleItemsInvalidationHandler)
    }

    /// Add an array of the decoration items that are anchored to the section, such as
    /// background decoration views.
    @warn_unqualified_access
    public func decorationItems(
        @LayoutDecorationItemBuilder _ decorationItems: () -> [LayoutDecorationItem]
    ) -> LayoutSection {
        let decorationItems = decorationItems().map(DecorationItemBuilder.make(from:))
        return valueModifier { $0.decorationItems.append(contentsOf: decorationItems) }
    }
}

extension LayoutSection {

    // MARK: - Content Insets

    /// Configure the amount of space between the content of the section and its boundaries.
    @warn_unqualified_access
    public func contentInsets(value: CGFloat) -> LayoutSection {
        return self.contentInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    /// Configure the amount of space between the content of the section and its boundaries.
    @warn_unqualified_access
    public func contentInsets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> LayoutSection {
        return self.contentInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    /// Configure the amount of space between the content of the section and its boundaries.
    @warn_unqualified_access
    public func contentInsets(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) -> LayoutSection {
        return self.contentInsets(
            NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
        )
    }

    /// Configure the amount of space between the content of the section and its boundaries.
    @warn_unqualified_access
    public func contentInsets(_ insets: NSDirectionalEdgeInsets) -> LayoutSection {
        valueModifier(insets, keyPath: \.contentInsets)
    }
}
