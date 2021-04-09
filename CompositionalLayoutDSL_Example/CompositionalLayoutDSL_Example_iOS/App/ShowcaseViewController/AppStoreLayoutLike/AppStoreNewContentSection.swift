//
//  AppStoreNewContentSection.swift
//  CompositionalLayoutDSL_Example_iOS
//
//  Created by Alexandre Podlewski on 09/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit
import CompositionalLayoutDSL

struct AppStoreNewContentSection: LayoutSection {

    let environment: NSCollectionLayoutEnvironment

    // MARK: - LayoutSection

    var sectionLayout: CollectionLayoutSectionConvertible {
        SectionWithEnvironmentInsets(
            insets: NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16),
            environment: environment
        ) { updatedEnvironment in
            AdaptativeColumnLaneSection(
                environment: updatedEnvironment,
                cellHeightProvider: { $0 * 9 / 16 + 88 }
            ) {
                Item {
                    SupplementaryItem(elementKind: UICollectionView.elementKindSectionHeader)
                        .height(.absolute(80))
                        .containerAnchor(
                            NSCollectionLayoutAnchor(
                                edges: .top,
                                absoluteOffset: CGPoint(x: 0, y: -88)
                            )
                        )
                        .zIndex(zIndex: 100)
                }
                .contentInsets(top: 88)
            }
            .orthogonalScrollingBehavior(.groupPaging)
        }
    }
}
