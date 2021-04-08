//
//  Section.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public struct Section: LayoutSection {

    private let group: LayoutGroup

    // MARK: - Life cycle

    public init(group: () -> LayoutGroup) {
        self.group = group()
    }

    // MARK: - LayoutSection

    public var sectionLayout: CollectionLayoutSectionConvertible {
        NSCollectionLayoutSection(group: group.collectionLayoutGroup)
    }
}
