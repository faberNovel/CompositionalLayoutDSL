//
//  LaneSection.swift
//  CompositionalLayoutDSL_Example_iOS
//
//  Created by Alexandre Podlewski on 09/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit
import CompositionalLayoutDSL

struct LaneSection: LayoutSection {

    let cellHeight: CGFloat
    let cellWidth: CGFloat
    let horizontalSpacing: CGFloat
    let itemProvider: () -> LayoutItem

    init(cellHeight: CGFloat,
         cellWidth: CGFloat,
         horizontalSpacing: CGFloat,
         itemProvider: @escaping () -> LayoutItem) {
        precondition(cellWidth > 0, "Cell width cannot be 0")
        precondition(cellHeight > 0, "Cell height cannot be 0")
        self.cellHeight = cellHeight
        self.cellWidth = cellWidth
        self.horizontalSpacing = horizontalSpacing
        self.itemProvider = itemProvider
    }

    var sectionLayout: CollectionLayoutSectionConvertible {
        Section {
            VGroup { itemProvider() }
                .width(.absolute(cellWidth))
                .height(.absolute(cellHeight))
        }
        .interGroupSpacing(horizontalSpacing)
        .orthogonalScrollingBehavior(.continuousGroupLeadingBoundary)
    }
}
