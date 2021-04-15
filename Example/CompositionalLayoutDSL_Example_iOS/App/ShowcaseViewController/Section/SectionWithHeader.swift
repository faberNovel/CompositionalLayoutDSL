//
//  SectionWithHeader.swift
//  CompositionalLayoutDSL_Example_iOS
//
//  Created by Alexandre Podlewski on 09/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit
import CompositionalLayoutDSL

struct SectionWithHeader: LayoutSection {

    var kind: String = UICollectionView.elementKindSectionHeader
    var height: NSCollectionLayoutDimension = .absolute(30)
    var section: () -> LayoutSection

    var sectionLayout: LayoutSection {
        section()
            .boundarySupplementaryItems {
                BoundarySupplementaryItem(elementKind: kind)
                    .height(height)
                    .alignment(.top)
            }
    }
}

// Same layout with only UIKit APIs

struct TraditionalSectionWithHeader: LayoutSection {

    var kind: String = UICollectionView.elementKindSectionHeader
    var height: NSCollectionLayoutDimension = .absolute(30)
    var baseSectionLayout: NSCollectionLayoutSection

    var sectionLayout: LayoutSection {
        let headerItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: height
        )
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerItemSize,
            elementKind: kind,
            alignment: .top
        )
        baseSectionLayout.boundarySupplementaryItems.append(headerItem)

        return baseSectionLayout
    }
}
