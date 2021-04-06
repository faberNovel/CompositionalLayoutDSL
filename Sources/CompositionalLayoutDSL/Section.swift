//
//  Section.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 06/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import Foundation
import UIKit

public struct Section: ContentInsetable {

    private let group: Group
    var interGroupSpacing: CGFloat = 0
    public var contentInsets: NSDirectionalEdgeInsets = .zero
    var orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none
    var boundarySupplementaryItems: [BoundarySupplementaryItem] = []

    public init(group: () -> Group) {
        self.group = group()
    }

    public func contentInsets(top: CGFloat = 0,
                              leading: CGFloat = 0,
                              bottom: CGFloat = 0,
                              trailing: CGFloat = 0) -> Section {
        return with(self) {
            $0.contentInsets = NSDirectionalEdgeInsets(
                top: top,
                leading: leading,
                bottom: bottom,
                trailing: trailing
            )
        }
    }

    public func interGroupSpacing(_ spacing: CGFloat) -> Section {
        return with(self) { $0.interGroupSpacing = spacing }
    }

    public func orthogonalScrollingBehavior(
        _ behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
    ) -> Section {
        with(self) { $0.orthogonalScrollingBehavior = behavior }
    }

    public func boundarySupplementaryItems(
        @BoundarySupplementaryItemBuilder items: () -> [BoundarySupplementaryItem]
    ) -> Self {
        with(self) { $0.boundarySupplementaryItems = items() }
    }

    func makeSection() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(
            group: group.makeGroup()
        )
        section.contentInsets = contentInsets
        section.interGroupSpacing = interGroupSpacing
        section.orthogonalScrollingBehavior = orthogonalScrollingBehavior
        section.boundarySupplementaryItems = boundarySupplementaryItems.map {
            $0.makeItem()
        }
        return section
    }
}
