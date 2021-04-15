//
//  Section.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public struct Section: LayoutSection, ContentInsetable {

    internal var contentInsets: NSDirectionalEdgeInsets = .zero
    internal var interGroupSpacing: CGFloat = 0
    internal var contentInsetsReference: ContentInsetsReference = .safeArea
    internal var orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none
    internal var boundarySupplementaryItems: [LayoutBoundarySupplementaryItem] = []
    internal var supplementariesFollowContentInsets: Bool = true
    internal var visibleItemsInvalidationHandler: NSCollectionLayoutSectionVisibleItemsInvalidationHandler?
    internal var decorationItems: [LayoutDecorationItem] = []
    private let group: LayoutGroup

    // MARK: - Life cycle

    public init(group: () -> LayoutGroup) {
        self.group = group()
    }

    // MARK: - LayoutSection

    public var sectionLayout: LayoutSection {
        return self
    }

    public func _makeSection() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group._makeGroup())
        section.apply(sectionPropertiesFrom: self)
        return section
    }
}

extension Section: HasSectionProperties {}
