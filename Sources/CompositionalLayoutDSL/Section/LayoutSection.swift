//
//  LayoutSection.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public protocol LayoutSection {
    var layoutSection: LayoutSection { get }
}

extension LayoutSection {
    public func interGroupSpacing(_ spacing: CGFloat) -> LayoutSection {
        valueModifier(spacing, keyPath: \.interGroupSpacing)
    }

    @available(iOS 14.0, tvOS 14.0, *)
    public func contentInsetsReference(_ reference: UIContentInsetsReference) -> LayoutSection {
        valueModifier(reference, keyPath: \.contentInsetsReference)
    }

    public func orthogonalScrollingBehavior(
        _ orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
    ) -> LayoutSection {
        valueModifier(orthogonalScrollingBehavior, keyPath: \.orthogonalScrollingBehavior)
    }

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

    public func supplementariesFollowContentInsets(
        _ supplementariesFollowContentInsets: Bool
    ) -> LayoutSection {
        valueModifier(supplementariesFollowContentInsets, keyPath: \.supplementariesFollowContentInsets)
    }

    public func visibleItemsInvalidationHandler(
        _ visibleItemsInvalidationHandler: NSCollectionLayoutSectionVisibleItemsInvalidationHandler?
    ) -> LayoutSection {
        valueModifier(visibleItemsInvalidationHandler, keyPath: \.visibleItemsInvalidationHandler)
    }

    public func decorationItems(
        @LayoutDecorationItemBuilder _ decorationItems: () -> [LayoutDecorationItem]
    ) -> LayoutSection {
        let decorationItems = decorationItems().map(DecorationItemBuilder.make(from:))
        return valueModifier { $0.decorationItems.append(contentsOf: decorationItems) }
    }
}

extension LayoutSection {

    // MARK: - Content Insets

    public func contentInsets(value: CGFloat) -> LayoutSection {
        return contentInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    public func contentInsets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> LayoutSection {
        return contentInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    public func contentInsets(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) -> LayoutSection {
        contentInsets(NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }

    public func contentInsets(_ insets: NSDirectionalEdgeInsets) -> LayoutSection {
        modifier(ContentInsetModifier(insets: insets))
    }
}
