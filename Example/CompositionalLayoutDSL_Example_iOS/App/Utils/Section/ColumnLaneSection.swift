//
//  ColumnLaneSection.swift
//  CompositionalLayoutDSL_Example_iOS
//
//  Created by Alexandre Podlewski on 09/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit
import CompositionalLayoutDSL

enum ColumnLaneInterItemSpacing {
    case standard
    case custom(spacing: CGFloat)
}

struct ColumnLaneSection: LayoutSection {

    let columns: Float
    /// Returns cell height from the cell width
    let cellHeightProvider: (CGFloat) -> CGFloat
    let interItemSpacing: ColumnLaneInterItemSpacing
    let environment: NSCollectionLayoutEnvironment
    let itemProvider: () -> LayoutItem

    // MARK: - LayoutSection

    var sectionLayout: CollectionLayoutSectionConvertible {
        Section {
            VGroup { itemProvider() }
                .width(.absolute(cellWidth))
                .height(.absolute(cellHeight))
        }
        .interGroupSpacing(horizontalSpacing)
        .orthogonalScrollingBehavior(.continuousGroupLeadingBoundary)
    }

    // MARK: - Private

    private var cellWidth: CGFloat {
        let cumulatedHorizontalSpacing = horizontalSpacing * CGFloat(columns - 1)
        let effectiveWidth = environment.container.effectiveContentSize.width
        return (effectiveWidth - cumulatedHorizontalSpacing) / CGFloat(columns)
    }

    private var cellHeight: CGFloat {
        let cellHeight = cellHeightProvider(cellWidth)
        assert(cellHeight > 0, "Cell height can not be 0")
        return cellHeight
    }

    private var horizontalSpacing: CGFloat {
        switch interItemSpacing {
        case let .custom(spacing: customSpacing):
            return customSpacing
        case .standard:
            return 8
        }
    }
}

extension ColumnLaneSection {

    init(columns: Float,
         environment: NSCollectionLayoutEnvironment,
         cellHeightProvider: @escaping (CGFloat) -> CGFloat,
         itemProvider: @escaping () -> LayoutItem = { Item() }) {
        self.init(
            columns: columns,
            cellHeightProvider: cellHeightProvider,
            interItemSpacing: .standard,
            environment: environment,
            itemProvider: itemProvider
        )
    }

    init(columns: Float,
         environment: NSCollectionLayoutEnvironment,
         cellHeight: CGFloat,
         interItemSpacing: ColumnLaneInterItemSpacing = .standard,
         itemProvider: @escaping () -> LayoutItem = { Item() }) {
        assert(cellHeight > 0, "A 0 height is not allowed")
        self.init(
            columns: columns,
            cellHeightProvider: { _ in cellHeight },
            interItemSpacing: interItemSpacing,
            environment: environment,
            itemProvider: itemProvider
        )
    }
}
