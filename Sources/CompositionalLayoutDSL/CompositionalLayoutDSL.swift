//
//  CompositionalLayoutDSL.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 06/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import Foundation
import UIKit

@_functionBuilder
public struct ItemBuilder { // swiftlint:disable:this convenience_type

    public static func buildBlock(_ items: LayoutItem...) -> [LayoutItem] {
        Array(items)
    }
}

@_functionBuilder
public struct BoundarySupplementaryItemBuilder { // swiftlint:disable:this convenience_type

    public static func buildBlock(_ items: BoundarySupplementaryItem...) -> [BoundarySupplementaryItem] {
        Array(items)
    }
}

// swiftlint:disable identifier_name

public func LayoutBuilder(configuration: UICollectionViewCompositionalLayoutConfiguration = .init(),
                          closure: () -> Section) -> UICollectionViewCompositionalLayout {
    let section = closure().makeSection()
    return UICollectionViewCompositionalLayout(section: section, configuration: configuration)
}

public func SectionBuilder(closure: () -> Section) -> NSCollectionLayoutSection {
    closure().makeSection()
}
