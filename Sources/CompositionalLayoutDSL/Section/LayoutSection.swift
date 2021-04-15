//
//  LayoutSection.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public protocol LayoutSection {
    var sectionLayout: LayoutSection { get }
    func _makeSection() -> NSCollectionLayoutSection
}

public extension LayoutSection {
    func _makeSection() -> NSCollectionLayoutSection {
        sectionLayout._makeSection()
    }
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
        @BoundarySupplementaryItemBuilder
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
        @DecorationItemBuilder _ decorationItems: () -> [LayoutDecorationItem]
    ) -> Self {
        with(self) {
            $0.decorationItems.append(contentsOf: decorationItems())
        }
    }
}
