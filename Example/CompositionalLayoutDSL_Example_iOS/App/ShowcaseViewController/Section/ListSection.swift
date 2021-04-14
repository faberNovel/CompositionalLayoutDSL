//
//  ListSection.swift
//  CompositionalLayoutDSL_Example_iOS
//
//  Created by Alexandre Podlewski on 09/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit
import CompositionalLayoutDSL

struct ListSection: LayoutSection {

    var sectionLayout: CollectionLayoutSectionConvertible {
        Section {
            HGroup(count: 5) { Item() }
                .height(.fractionalWidth(1 / 5))
                .interItemSpacing(.fixed(4))
                .contentInsets(horizontal: 8, vertical: 0)
        }
        .interGroupSpacing(4)
        .boundarySupplementaryItems {
            BoundarySupplementaryItem(elementKind: UICollectionView.elementKindSectionHeader)
                .absoluteOffset(CGPoint(x: 0, y: -4))
                .height(.absolute(20))
                .alignment(.top)
                .pinToVisibleBounds(true)
            BoundarySupplementaryItem(elementKind: UICollectionView.elementKindSectionFooter)
                .absoluteOffset(CGPoint(x: 0, y: 4))
                .height(.absolute(20))
                .alignment(.bottom)
                .pinToVisibleBounds(true)
        }
    }
}

// Same layout with only UIKit APIs

struct TraditionalListSection: LayoutSection {

    var sectionLayout: CollectionLayoutSectionConvertible {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1 / 5)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 5)
        group.interItemSpacing = .fixed(4)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)

        let headerFooterItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(20)
        )
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterItemSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top,
            absoluteOffset: CGPoint(x: 0, y: -4)
        )
        headerItem.pinToVisibleBounds = true
        let footerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterItemSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom,
            absoluteOffset: CGPoint(x: 0, y: 4)
        )
        footerItem.pinToVisibleBounds = true

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 4
        section.boundarySupplementaryItems = [
            headerItem,
            footerItem
        ]

        return section
    }
}
