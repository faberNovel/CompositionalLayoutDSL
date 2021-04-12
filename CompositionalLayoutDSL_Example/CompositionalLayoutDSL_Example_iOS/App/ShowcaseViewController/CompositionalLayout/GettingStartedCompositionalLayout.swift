//
//  GettingStartedCompositionalLayout.swift
//  CompositionalLayoutDSL_Example_iOS
//
//  Created by Alexandre Podlewski on 12/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit
import CompositionalLayoutDSL

struct GettingStartedCompositionalLayout {
    func layout() -> UICollectionViewLayout {
        return LayoutBuilder {
            Section {
                VGroup(count: 1) { Item() }
                    .height(.fractionalWidth(0.3))
                    .width(.fractionalWidth(0.3))
                    .interItemSpacing(.fixed(8))
            }
            .interGroupSpacing(8)
            .contentInsets(horizontal: 16, vertical: 8)
            .orthogonalScrollingBehavior(.continuous)
            .supplementariesFollowContentInsets(false)
            .boundarySupplementaryItems {
                BoundarySupplementaryItem(elementKind: UICollectionView.elementKindSectionHeader)
                    .height(.absolute(30))
                    .alignment(.top)
                    .pinToVisibleBounds(true)
            }
        }
    }
}
