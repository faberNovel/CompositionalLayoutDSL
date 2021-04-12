//
//  CompositionalLayoutConfiguration.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 12/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

// MARK: - CollectionLayoutConfigurationConvertible

public protocol CollectionLayoutConfigurationConvertible {
    var collectionLayoutConfiguration: UICollectionViewCompositionalLayoutConfiguration { get }
}

extension UICollectionViewCompositionalLayoutConfiguration: CollectionLayoutConfigurationConvertible {
    public var collectionLayoutConfiguration: UICollectionViewCompositionalLayoutConfiguration { self }
}

// MARK: - CompositionalLayoutConfiguration

public protocol CompositionalLayoutConfiguration: CollectionLayoutConfigurationConvertible {
    var layoutConfiguration: CollectionLayoutConfigurationConvertible { get }
}

public extension CompositionalLayoutConfiguration {

    // MARK: - CollectionLayoutConfigurationConvertible

    var collectionLayoutConfiguration: UICollectionViewCompositionalLayoutConfiguration {
        layoutConfiguration.collectionLayoutConfiguration
    }
}

extension UICollectionViewCompositionalLayoutConfiguration: CompositionalLayoutConfiguration {
    public var layoutConfiguration: CollectionLayoutConfigurationConvertible { self }
}

public extension CompositionalLayoutConfiguration {

    // MARK: - Mutable properties

    func scrollDirection(
        _ scrollDirection: UICollectionView.ScrollDirection
    ) -> CompositionalLayoutConfiguration {
        with(collectionLayoutConfiguration) { $0.scrollDirection = scrollDirection }
    }

    func interSectionSpacing(_ interSectionSpacing: CGFloat) -> CompositionalLayoutConfiguration {
        with(collectionLayoutConfiguration) { $0.interSectionSpacing = interSectionSpacing }
    }

    func boundarySupplementaryItems(
        @BoundarySupplementaryItemBuilder
        _ boundarySupplementaryItems: () -> [LayoutBoundarySupplementaryItem]
    ) -> CompositionalLayoutConfiguration {
        with(collectionLayoutConfiguration) {
            $0.boundarySupplementaryItems.append(
                contentsOf: boundarySupplementaryItems().map(\.collectionLayoutBoundarySupplementaryItem)
            )
        }
    }

    @available(iOS 14.0, tvOS 14.0, *)
    func contentInsetsReference(
        _ contentInsetsReference: UIContentInsetsReference
    ) -> CompositionalLayoutConfiguration {
        with(collectionLayoutConfiguration) {
            $0.contentInsetsReference = contentInsetsReference
        }
    }    
}
