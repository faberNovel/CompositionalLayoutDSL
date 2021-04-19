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

extension HasSectionProperties {
    public func interGroupSpacing(_ spacing: CGFloat) -> Self {
        with(self) { $0.interGroupSpacing = spacing }
    }

    @available(iOS 14.0, tvOS 14.0, *)
    public func contentInsetsReference(_ reference: UIContentInsetsReference) -> Self {
        with(self) { $0.contentInsetsReference = ContentInsetsReference(from: reference) }
    }

    public func orthogonalScrollingBehavior(
        _ orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
    ) -> Self {
        with(self) { $0.orthogonalScrollingBehavior = orthogonalScrollingBehavior }
    }

    public func boundarySupplementaryItems(
        @LayoutBoundarySupplementaryItemBuilder
        _ boundarySupplementaryItems: () -> [LayoutBoundarySupplementaryItem]
    ) -> Self {
        with(self) {
            $0.boundarySupplementaryItems.append(
                contentsOf: boundarySupplementaryItems()
            )
        }
    }

    public func supplementariesFollowContentInsets(
        _ supplementariesFollowContentInsets: Bool
    ) -> Self {
        with(self) {
            $0.supplementariesFollowContentInsets = supplementariesFollowContentInsets
        }
    }

    public func visibleItemsInvalidationHandler(
        _ visibleItemsInvalidationHandler: NSCollectionLayoutSectionVisibleItemsInvalidationHandler?
    ) -> Self {
        with(self) {
            $0.visibleItemsInvalidationHandler = visibleItemsInvalidationHandler
        }
    }

    public func decorationItems(
        @LayoutDecorationItemBuilder _ decorationItems: () -> [LayoutDecorationItem]
    ) -> Self {
        with(self) {
            $0.decorationItems.append(contentsOf: decorationItems())
        }
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
