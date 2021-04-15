//
//  HasConfigurationProperties.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 15/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

internal protocol HasConfigurationProperties {
    var scrollDirection: UICollectionView.ScrollDirection { get set }
    var interSectionSpacing: CGFloat { get set }
    var boundarySupplementaryItems: [LayoutBoundarySupplementaryItem] { get set }
    @available(iOS 14.0, tvOS 14.0, *)
    var contentInsetsReference: ContentInsetsReference { get set }
}

internal extension UICollectionViewCompositionalLayoutConfiguration {
    func apply(configurationPropertiesFrom propertiesHolder: HasConfigurationProperties) {
        self.scrollDirection = propertiesHolder.scrollDirection
        self.interSectionSpacing = propertiesHolder.interSectionSpacing
        self.boundarySupplementaryItems = propertiesHolder.boundarySupplementaryItems.map {
            $0._makeBoundarySupplementaryItem()
        }
        if #available(iOS 14.0, tvOS 14.0, *) {
            self.contentInsetsReference = propertiesHolder.contentInsetsReference.uiKitValue
        }
    }
}
