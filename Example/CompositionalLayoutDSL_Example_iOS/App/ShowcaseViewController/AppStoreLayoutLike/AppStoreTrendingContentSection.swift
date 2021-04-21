//
//  AppStoreTrendingContentSection.swift
//  CompositionalLayoutDSL_Example_iOS
//
//  Created by Alexandre Podlewski on 09/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit
import CompositionalLayoutDSL

struct AppStoreTrendingContentSection: LayoutSection {

    let environment: NSCollectionLayoutEnvironment

    // MARK: - LayoutSection

    var layoutSection: LayoutSection {
        SectionWithEnvironmentInsets(
            insets: NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16),
            environment: environment
        ) { updatedEnvironment in
            AdaptativeColumnLaneSection(
                environment: updatedEnvironment,
                cellHeight: 240
            ) {
                VGroup(count: 3) {
                    Item()
                }
                .interItemSpacing(.fixed(4))
            }
            .orthogonalScrollingBehavior(.groupPaging)
        }
    }
}
