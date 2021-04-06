//
//  CompositionalLayoutDSL.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 06/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import Foundation
import UIKit

public typealias ItemBuilder = ListResultBuilder<LayoutItem>
public typealias BoundarySupplementaryItemBuilder = ListResultBuilder<BoundarySupplementaryItem>

// swiftlint:disable identifier_name

public func LayoutBuilder(configuration: UICollectionViewCompositionalLayoutConfiguration = .init(),
                          closure: () -> Section) -> UICollectionViewCompositionalLayout {
    let section = closure().makeSection()
    return UICollectionViewCompositionalLayout(section: section, configuration: configuration)
}

public func SectionBuilder(closure: () -> Section) -> NSCollectionLayoutSection {
    closure().makeSection()
}
