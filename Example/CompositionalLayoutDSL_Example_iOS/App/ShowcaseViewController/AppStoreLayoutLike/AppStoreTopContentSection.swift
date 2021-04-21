//
//  AppStoreTopContentSection.swift
//  CompositionalLayoutDSL_Example_iOS
//
//  Created by Alexandre Podlewski on 09/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit
import CompositionalLayoutDSL

struct AppStoreTopContentSection: LayoutSection {

    let environment: NSCollectionLayoutEnvironment

    // MARK: - LayoutSection

    var layoutSection: LayoutSection {
        SectionWithHeader {
            SectionWithEnvironmentInsets(
                insets: NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16),
                environment: environment
            ) { _ in
                LaneSection(
                    cellHeight: 300 * 9 / 16 + 30,
                    cellWidth: 300,
                    horizontalSpacing: 16
                ) {
                    Item {
                        SupplementaryItem(elementKind: UICollectionView.elementKindSectionFooter)
                            .containerAnchor(
                                NSCollectionLayoutAnchor(
                                    edges: .bottom,
                                    absoluteOffset: CGPoint(x: 0, y: 30)
                                )
                            )
                            .height(.absolute(26))
                    }
                    .contentInsets(bottom: 30)
                }
                .orthogonalScrollingBehavior(.groupPaging)
            }
        }
        .supplementariesFollowContentInsets(false)
    }
}
