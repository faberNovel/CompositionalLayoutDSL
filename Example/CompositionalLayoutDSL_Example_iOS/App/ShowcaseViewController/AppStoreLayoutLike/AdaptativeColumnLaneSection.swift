//
//  AdaptativeColumnLaneSection.swift
//  CompositionalLayoutDSL_Example_iOS
//
//  Created by Alexandre Podlewski on 09/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit
import CompositionalLayoutDSL

struct AdaptativeColumnLaneSection: LayoutSection {

    /// Returns cell height from the cell width
    let cellHeightProvider: (CGFloat) -> CGFloat
    let interItemSpacing: ColumnLaneInterItemSpacing
    let environment: NSCollectionLayoutEnvironment
    let itemProvider: () -> LayoutItem

    // MARK: - LayoutSection

    var layoutSection: LayoutSection {
        ColumnLaneSection(
            columns: columns,
            cellHeightProvider: cellHeightProvider,
            interItemSpacing: interItemSpacing,
            environment: environment,
            itemProvider: itemProvider
        )
    }

    // MARK: - Private

    private var columns: Float {
        switch environment.container.effectiveContentSize.width {
        case ..<500:
            return 1
        case 500..<700:
            return 1.5
        case 700...:
            return 2.5
        default:
            return 2.5
        }
    }
}

extension AdaptativeColumnLaneSection {

    init(environment: NSCollectionLayoutEnvironment,
         cellHeightProvider: @escaping (CGFloat) -> CGFloat,
         itemProvider: @escaping () -> LayoutItem = { Item() }) {
        self.init(
            cellHeightProvider: cellHeightProvider,
            interItemSpacing: .standard,
            environment: environment,
            itemProvider: itemProvider
        )
    }

    init(environment: NSCollectionLayoutEnvironment,
         cellHeight: CGFloat,
         interItemSpacing: ColumnLaneInterItemSpacing = .standard,
         itemProvider: @escaping () -> LayoutItem = { Item() }) {
        assert(cellHeight > 0, "A 0 height is not allowed")
        self.init(
            cellHeightProvider: { _ in cellHeight },
            interItemSpacing: interItemSpacing,
            environment: environment,
            itemProvider: itemProvider
        )
    }
}
