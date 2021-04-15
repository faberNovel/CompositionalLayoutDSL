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
    func _makeConfiguration() -> UICollectionViewCompositionalLayoutConfiguration
}

extension HasConfigurationProperties {

    // MARK: - Mutable properties

    public func scrollDirection(
        _ scrollDirection: UICollectionView.ScrollDirection
    ) -> Self {
        with(self) { $0.scrollDirection = scrollDirection }
    }

    public func interSectionSpacing(_ interSectionSpacing: CGFloat) -> Self {
        with(self) { $0.interSectionSpacing = interSectionSpacing }
    }

    public func boundarySupplementaryItems(
        @BoundarySupplementaryItemBuilder
        _ boundarySupplementaryItems: () -> [LayoutBoundarySupplementaryItem]
    ) -> Self {
        with(self) { $0.boundarySupplementaryItems.append(contentsOf: boundarySupplementaryItems()) }
    }

//    @available(iOS 14.0, tvOS 14.0, *)
//    public func contentInsetsReference(
//        _ contentInsetsReference: UIContentInsetsReference
//    ) -> Self {
//        with(self) {
//            $0.contentInsetsReference = contentInsetsReference
//        }
//    }
}
