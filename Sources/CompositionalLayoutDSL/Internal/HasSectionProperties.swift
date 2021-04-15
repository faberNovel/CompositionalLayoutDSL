//
//  HasSectionProperties.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 15/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

internal protocol HasSectionProperties: HasContentInsetProperties {
    var interGroupSpacing: CGFloat { get set }
    //    @available(iOS 14.0, tvOS 14.0, *)
    //    var contentInsetsReference: UIContentInsetsReference { get set }
    var orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior { get set }
    var boundarySupplementaryItems: [LayoutBoundarySupplementaryItem] { get set }
    var supplementariesFollowContentInsets: Bool { get set }
    var visibleItemsInvalidationHandler: NSCollectionLayoutSectionVisibleItemsInvalidationHandler? { get set }
    var decorationItems: [LayoutDecorationItem] { get set }
}

extension NSCollectionLayoutSection {
    func apply(sectionPropertiesFrom propertiesHolder: HasSectionProperties) {
        self.contentInsets = propertiesHolder.contentInsets
        self.interGroupSpacing = propertiesHolder.interGroupSpacing
        //        if #available(iOS 14.0, *) {
        //            self.contentInsetsReference = propertiesHolder.contentInsetsReference
        //        }
        self.orthogonalScrollingBehavior = propertiesHolder.orthogonalScrollingBehavior
        self.boundarySupplementaryItems = propertiesHolder.boundarySupplementaryItems.map {
            $0._makeBoundarySupplementaryItem()
        }
        self.supplementariesFollowContentInsets = propertiesHolder.supplementariesFollowContentInsets
        self.visibleItemsInvalidationHandler = propertiesHolder.visibleItemsInvalidationHandler
        self.decorationItems = propertiesHolder.decorationItems.map { $0._makeDecorationItem() }
    }
}
