//
//  LayoutSection.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

// MARK: - CollectionLayoutSectionConvertible

public protocol CollectionLayoutSectionConvertible {
    var collectionLayoutSection: NSCollectionLayoutSection { get }
}

extension NSCollectionLayoutSection: CollectionLayoutSectionConvertible {
    public var collectionLayoutSection: NSCollectionLayoutSection { self }
}

// MARK: - LayoutSection

public protocol LayoutSection: CollectionLayoutSectionConvertible {
    var sectionLayout: CollectionLayoutSectionConvertible { get }
}

public extension LayoutSection {

    // MARK: - CollectionLayoutSectionConvertible

    var collectionLayoutSection: NSCollectionLayoutSection { sectionLayout.collectionLayoutSection }
}

extension NSCollectionLayoutSection: LayoutSection {
    public var sectionLayout: CollectionLayoutSectionConvertible { self }
}


public extension LayoutSection {

    // MARK: - Mutable properties

    func contentInsets(value: CGFloat) -> LayoutSection {
        return contentInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    func contentInsets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> LayoutSection {
        return contentInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    func contentInsets(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) -> LayoutSection {
        return with(collectionLayoutSection) {
            $0.contentInsets = NSDirectionalEdgeInsets(
                top: top,
                leading: leading,
                bottom: bottom,
                trailing: trailing
            )
        }
    }

    func interGroupSpacing(_ spacing: CGFloat) -> LayoutSection {
        with(collectionLayoutSection) { $0.interGroupSpacing = spacing }
    }

    @available(iOS 14.0, tvOS 14.0, *)
    func contentInsetsReference(_ reference: UIContentInsetsReference) -> LayoutSection {
        with(collectionLayoutSection) { $0.contentInsetsReference = reference }
    }

    func orthogonalScrollingBehavior(
        _ orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
    ) -> LayoutSection {
        with(collectionLayoutSection) { $0.orthogonalScrollingBehavior = orthogonalScrollingBehavior }
    }

    func boundarySupplementaryItems(
        @BoundarySupplementaryItemBuilder _ boundarySupplementaryItems: () -> [CollectionLayoutBoundarySupplementaryItemConvertible]
    ) -> LayoutSection {
        with(collectionLayoutSection) {
            $0.boundarySupplementaryItems.append(
                contentsOf: boundarySupplementaryItems().map { $0.collectionLayoutBoundarySupplementaryItem }
            )
        }
    }

    func supplementariesFollowContentInsets(
        _ supplementariesFollowContentInsets: Bool
    ) -> LayoutSection {
        with(collectionLayoutSection) {
            $0.supplementariesFollowContentInsets = supplementariesFollowContentInsets
        }
    }

    func visibleItemsInvalidationHandler(
        _ visibleItemsInvalidationHandler: NSCollectionLayoutSectionVisibleItemsInvalidationHandler?
    ) -> LayoutSection {
        with(collectionLayoutSection) {
            $0.visibleItemsInvalidationHandler = visibleItemsInvalidationHandler
        }
    }

    func decorationItems(
        @DecorationItemBuilder _ decorationItems: () -> [CollectionLayoutDecorationItemConvertible]
    ) -> LayoutSection {
        with(collectionLayoutSection) {
            $0.decorationItems.append(contentsOf: decorationItems().map(\.collectionLayoutDecorationItem))
        }
    }
}
